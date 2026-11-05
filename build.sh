#!/bin/sh
# Wraps src/app.html into a full HTML document for the webOS app.
set -e
cd "$(dirname "$0")"
{ printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=1920, height=1080">\n</head>\n<body>\n'; cat src/app.html; printf '\n</body>\n</html>\n'; } > webos/index.html
echo "built webos/index.html"
