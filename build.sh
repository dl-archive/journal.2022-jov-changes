#!/usr/bin/env bash
# Reproducible build with the TeX Live version of the original camera-ready build (Aug 2022, pdfTeX 1.40.24 = TeX Live 2022).
# Requires podman (or docker: export ENGINE=docker). Output: build/procedural-textures-treemaps.pdf
# SOURCE_DATE_EPOCH + FORCE_SOURCE_DATE: \today in "Received: \today" = date of the camera-ready build (2022-08-29)
# openout_any=a: bibtex runs from /src and must write its .bbl/.blg to /out
set -euo pipefail
cd "$(dirname "$0")"
ENGINE=${ENGINE:-podman}
IMAGE=docker.io/texlive/texlive:TL2022-historic
mkdir -p build
"$ENGINE" run --rm -e openout_any=a -e SOURCE_DATE_EPOCH=1661753100 -e FORCE_SOURCE_DATE=1 -v "$PWD/src:/src:ro,Z" -v "$PWD/build:/out:Z" -w /src "$IMAGE" \
  latexmk -pdf -interaction=nonstopmode -outdir=/out procedural-textures-treemaps.tex
