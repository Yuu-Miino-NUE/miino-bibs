import bibtexparser
import sys


class BibInfo:
    def __init__(self, file, total, international, domestic):
        self.file = file
        self.total = total
        self.international = international
        self.domestic = domestic


def get_bib_info(bibfile):
    try:
        with open(bibfile, "r") as file:
            bib_database = bibtexparser.load(file)
    except Exception as e:
        raise RuntimeError(f"Error reading {bibfile}: {e}")

    entry_count = len(bib_database.entries)
    entry_international = sum(
        1
        for entry in bib_database.entries
        if "bib_class" in entry and "international" in entry["bib_class"]
    )
    entry_domestic = sum(
        1
        for entry in bib_database.entries
        if "bib_class" in entry and "domestic" in entry["bib_class"]
    )
    if entry_count != (entry_international + entry_domestic):
        raise ValueError(
            f"Entry count mismatch in {bibfile}: "
            f"{entry_count} total vs "
            f"{entry_international} international + "
            f"{entry_domestic} domestic"
        )

    return BibInfo(
        file=bibfile,
        total=entry_count,
        international=entry_international,
        domestic=entry_domestic,
    )


if __name__ == "__main__":
    try:
        file_arr = sys.argv[1:]
        all_data = [get_bib_info(bibfile) for bibfile in file_arr]
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)

    total = sum(d.total for d in all_data)
    print(f"Total: {total:3d} entries")

    for d in all_data:
        print(
            f"{d.file:<30}: {d.total:3d} entries "
            f"({d.international:3d} international, "
            f"{d.domestic:3d} domestic)"
        )
