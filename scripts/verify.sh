#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 John Conklin
# Rebuilds campus.db from scratch and runs every lesson solution.
# Fails if any SQL statement errors.
set -euo pipefail
cd "$(dirname "$0")/.."
DB="$(mktemp -d)/campus.db"
sqlite3 -bail "$DB" < database/campus.sql
echo "Built database: $(sqlite3 "$DB" 'SELECT COUNT(*) FROM enrollments;') enrollments"
for f in lessons/*/solution.sql; do
  sqlite3 -bail "$DB" < "$f" > /dev/null
  echo "OK  $f"
done
sqlite3 -bail "$DB" < solutions/answer_key.sql > /dev/null
echo "OK  solutions/answer_key.sql"
echo "All solutions ran successfully."
