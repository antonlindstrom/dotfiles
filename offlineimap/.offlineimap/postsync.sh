#!/bin/bash

notmuch new
notmuch tag --batch --input=/home/anton/.offlineimap/notmuch_tags

TEMP_DIR=$(mktemp -d)
TARGET="$HOME/documents/payslips/"

payslips=$(notmuch search --format=text0 --output=files tag:payslip | xargs -0 -I {} --no-run-if-empty echo {})

for email in $payslips; do
	datefile=$(mktemp)
	cat "$email" | grep Date: | cut -d' ' -f 2- > "$datefile"
	prefix=$(date -f "$datefile" "+%Y%m%d_%H%M")

	ripmime -i "$email" -d "$TEMP_DIR"

	for file in "$TEMP_DIR"/*.pdf; do
		b=$(basename "$file")
		mv "$file" "$TEMP_DIR/${prefix}_$b" 2>/dev/null
	done

	rsync -a --include='*.pdf' --exclude='*' "$TEMP_DIR/" "$TARGET"
	rm -r "$TEMP_DIR"
done
