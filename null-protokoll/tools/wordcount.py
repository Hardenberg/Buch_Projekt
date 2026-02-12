from pathlib import Path
import re

paths = sorted(Path("manuskript").glob("*.md"))
total = 0

for p in paths:
    text = p.read_text(encoding="utf-8")
    words = re.findall(r"\b\w+\b", text, flags=re.UNICODE)
    total += len(words)

print(f"Total words: {total}")