#!/usr/bin/env python3
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 John Conklin
"""Run every lesson solution file in SQLite and compare each query's result
with the "-- Expected:" table written in the comments above it.

Usage: python3 scripts/check_expected.py   (from the repository root)
Exit code 1 if any result differs.
"""
import glob, os, re, sqlite3, sys, decimal

ROOT = os.path.relpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
CAMPUS = open(f'{ROOT}/database/campus.sql').read()

def norm(v):
    if v is None:
        return 'NULL'
    if isinstance(v, (int, float, decimal.Decimal)):
        f = float(v)
        return str(int(f)) if f == int(f) else ('%.6f' % f).rstrip('0')
    s = str(v).strip()
    try:
        f = float(s)
        return str(int(f)) if f == int(f) else ('%.6f' % f).rstrip('0')
    except ValueError:
        return s

def statements(sql):
    lines = [l for l in sql.split('\n')
             if l.strip() and not l.strip().startswith('--') and not l.startswith('.')]
    body = '\n'.join(lines)
    return [s.strip() for s in re.split(r';\s*(?:--[^\n]*)?(?:\n|$)', body) if s.strip()]

def expected_rows(chunk):
    """Rows of the first comment table after '-- Expected' (or 'Expected in SQLite')."""
    m = re.search(r'-- Expected(?: in SQLite)?:\n((?:-- \|.*\|\n)+)', chunk)
    if not m:
        return None
    rows = [l[3:].strip().strip('|').split('|') for l in m.group(1).strip().split('\n')]
    return [tuple(norm(c) for c in r) for r in rows[1:]]  # skip header

def fails_as_expected(conn, chunk):
    """Run the live statements, then the commented-out one; it must raise an error."""
    lines = chunk.split('\n')[2:]           # skip the label and the Expected line
    live = [l for l in lines if not l.startswith('--') and not l.startswith('ROLLBACK')]
    bad = [l[3:] for l in lines if l.startswith('-- ') and not l.startswith('-- The next')]
    in_tx = any(l.strip() == 'BEGIN;' for l in live)
    if not in_tx:
        conn.execute('BEGIN')
    for s in statements('\n'.join(live)):
        if s.upper() != 'BEGIN':
            conn.execute(s)
    try:
        for s in statements('\n'.join(bad)):
            conn.execute(s)
        ok = False
    except sqlite3.Error:
        ok = True
    if conn.in_transaction:
        conn.execute('ROLLBACK')
    return ok

def check_file(path):
    text = open(path).read()
    conn = sqlite3.connect(':memory:', isolation_level=None)
    if '-- Database: campus' in text:
        conn.executescript(CAMPUS)
    chunks = re.split(r'\n(?=-- ===== )', text)
    fails = checked = 0
    for chunk in chunks:
        label = chunk.split('\n')[0].replace('-- ===== ', '').split(' ')[0]
        exp = expected_rows(chunk)
        rows = None
        if '-- Expected: error' in chunk:
            checked += 1
            if not fails_as_expected(conn, chunk):
                fails += 1
                print(f'MISMATCH {path} {label}: a statement marked "error" ran without an error')
            continue
        for s in statements(chunk):
            cur = conn.execute(s)
            if cur.description:
                rows = [tuple(norm(v) for v in r) for r in cur.fetchall()]
        if exp is not None:
            checked += 1
            if rows != exp:
                fails += 1
                print(f'MISMATCH {path} {label}\n  expected {exp}\n  got      {rows}')
        elif '-- Expected: 0 rows' in chunk:
            checked += 1
            if rows != []:
                fails += 1
                print(f'MISMATCH {path} {label}: expected 0 rows, got {rows}')
    print(f'{"OK " if not fails else "FAIL"} {path}: {checked} results checked')
    return fails

total = sum(check_file(p) for p in sorted(glob.glob(f'{ROOT}/lessons/**/*.sql', recursive=True)))
sys.exit(1 if total else 0)
