from datetime import datetime
from pathlib import Path
import re

BASE_DIR = Path(__file__).resolve().parents[1]
MANUSKRIPT_DIR = BASE_DIR / "manuskript"
EXPORT_DIR = BASE_DIR / "export"
LOG_FILE = EXPORT_DIR / "wordcount_log.csv"


def count_words() -> int:
    total = 0
    paths = sorted(MANUSKRIPT_DIR.glob("*.md"))
    for p in paths:
        text = p.read_text(encoding="utf-8")
        # Ignore markdown headings (e.g. chapter titles).
        text = re.sub(r"^\s{0,3}#{1,6}\s+.*$", "", text, flags=re.MULTILINE)
        words = re.findall(r"\b\w+\b", text, flags=re.UNICODE)
        total += len(words)
    return total


def append_log(words: int) -> None:
    EXPORT_DIR.mkdir(parents=True, exist_ok=True)
    if not LOG_FILE.exists():
        LOG_FILE.write_text("date,time,words\n", encoding="utf-8")

    now = datetime.now()
    log_line = f"{now:%Y-%m-%d},{now:%H:%M:%S},{words}\n"
    with LOG_FILE.open("a", encoding="utf-8") as f:
        f.write(log_line)


if __name__ == "__main__":
    total_words = count_words()
    append_log(total_words)
    print(f"Total words: {total_words}")
    print(f"Logged to: {LOG_FILE}")
