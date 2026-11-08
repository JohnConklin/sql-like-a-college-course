#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 John Conklin
# 1. Runs every lesson solution file with the sqlite3 command-line tool, each in
#    a fresh database (campus.db, or an empty one if the file says so).
# 2. Compares every query result with the expected output in the comments.
# Fails if any statement errors or any result differs.
set -euo pipefail
cd "$(dirname "$0")/.."
TMP="$(mktemp -d)"
sqlite3 -bail "$TMP/check.db" < database/campus.sql
echo "Built database: $(sqlite3 "$TMP/check.db" 'SELECT COUNT(*) FROM Enrollment;') enrollments"
n=0
while IFS= read -r f; do
  n=$((n + 1))
  DB="$TMP/lesson$n.db"
  if grep -q -- '-- Database: campus' "$f"; then
    sqlite3 -bail "$DB" < database/campus.sql
  fi
  (cd "$(dirname "$f")" && sqlite3 -bail "$DB" < "$(basename "$f")" > /dev/null)
  echo "RAN $f"
done < <(find lessons -name '*.sql' | sort)
python3 scripts/check_expected.py
echo "All solutions ran and matched their expected results."
