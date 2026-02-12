from pathlib import Path
import re

paths = sorted(Path("manuskript").glob("*.md"))
total = 0

for p in paths:
    text = p.read_text(encoding="utf-8")
    # Ignore markdown headings (e.g. chapter titles).
    text = re.sub(r"^\s{0,3}#{1,6}\s+.*$", "", text, flags=re.MULTILINE)
    words = re.findall(r"\b\w+\b", text, flags=re.UNICODE)
    total += len(words)

print(f"Total words: {total}")
