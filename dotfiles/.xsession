#!/usr/bin/env bash
set -euo pipefail

# Desktop personalization
#  - Background random
#  - Compose for alpha transparency
feh --bg-fill --randomize ~/Imágenes/wall/* &
compton &

exit 0
