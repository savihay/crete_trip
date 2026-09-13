#!/bin/sh
# Downloads the four missing destination photos from Wikimedia Commons.
# All freely licensed (CC BY-SA / CC BY). Run from the repository root:
#     sh images/fetch-photos.sh
#
# Every destination loads images/<id>.jpg and falls back to images/<id>.svg,
# so the moment a .jpg lands here the site picks it up with no code change.

set -e
cd "$(dirname "$0")"

command -v curl >/dev/null 2>&1 || { echo "curl not found"; exit 1; }

# <output name>|<Wikimedia Commons file name>|<credit>
LIST='
knossos|Knossos - North Portico 02.jpg|Knossos North Portico, Wikimedia Commons, CC BY-SA
frangokastello|Crete - Frangokastello castle north.jpg|Frangokastello castle, Wikimedia Commons, CC BY-SA
argyroupoli|Ancient Lappa, Argyroupoli, Crete 2.jpg|Argyroupoli (Ancient Lappa), Wikimedia Commons, CC BY-SA
heraklion-museum|Phaistos Disc - Heraklion Archaeological Museum by Joy of Museums.jpg|Phaistos Disc, Heraklion Archaeological Museum, Wikimedia Commons, CC BY-SA
'

: > CREDITS.md
echo "# קרדיטים לתמונות" >> CREDITS.md
echo "" >> CREDITS.md
echo "התמונות הבאות הורדו מ-Wikimedia Commons ברישיון חופשי." >> CREDITS.md
echo "" >> CREDITS.md

echo "$LIST" | while IFS='|' read -r name file credit; do
  [ -z "$name" ] && continue

  # Special:FilePath resolves a Commons file name to the actual image and
  # resizes server-side, so we never pull the full 5000px original.
  slug=$(printf '%s' "$file" | sed 's/ /_/g')
  url="${WX_BASE:-https://commons.wikimedia.org/wiki/Special:FilePath}/$slug?width=1200"

  printf 'Downloading %-18s ... ' "$name.jpg"
  if curl -fsSL --max-time 90 -A 'crete-trip/1.0 (personal family trip page)' -o "$name.jpg.tmp" "$url"; then
    case "$(file -b --mime-type "$name.jpg.tmp" 2>/dev/null)" in
      image/jpeg|image/png|image/webp)
        mv "$name.jpg.tmp" "$name.jpg"
        echo "ok  ($(du -h "$name.jpg" | cut -f1))"
        echo "- **$name.jpg** — $credit" >> CREDITS.md
        echo "  https://commons.wikimedia.org/wiki/File:$slug" >> CREDITS.md
        ;;
      *)
        rm -f "$name.jpg.tmp"
        echo "FAILED (not an image — the file may have been renamed on Commons)"
        ;;
    esac
  else
    rm -f "$name.jpg.tmp"
    echo "FAILED (network or file not found)"
  fi
done

echo ""
echo "Done. Review the images, then:  git add images && git commit && git push"
echo "Credits written to images/CREDITS.md"
