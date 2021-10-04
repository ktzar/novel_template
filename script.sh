#!/bin/sh
BUILDIR=build
COVER_IMAGE=cover.jpg
PDF_FILE=$BUILDIR/book.pdf
EPUB_FILE=$BUILDIR/book.epub
TXT_FILE=$BUILDIR/book.txt
DOCX_FILE=$BUILDIR/book.docx
ODT_FILE=$BUILDIR/book.odt
CHAPTERS=chapters/*.md 
TOC="--toc --toc-depth=1 "
METADATA=--metadata-file=meta/metadata.yml

# install any fonts needed
# apk add ttf-linux-libertine
# refresh the font cache
fc-cache -fv > /dev/null
# show all the fonts in the system you can use
# fc-list

rm -fR $BUILDIR
mkdir -p $BUILDIR

# in case you want to tweak the latex template
# pandoc -D latex > template.tex

pandoc \
    $METADATA \
    $TOC \
     --pdf-engine=xelatex \
    -V geometry:"width=4in,height=6.5in" \
    -o $PDF_FILE \
    $CHAPTERS
echo PDF built

pandoc \
    $METADATA \
    $TOC \
    --css=style.css \
     --epub-cover-image=$COVER_IMAGE \
    -o $EPUB_FILE \
    $CHAPTERS
echo EPUB built

pandoc \
    $METADATA \
    $TOC \
    -o $TXT_FILE \
    $CHAPTERS
echo TXT built

pandoc \
    $METADATA \
    $TOC \
    -o $DOCX_FILE \
    --reference-doc=templates/reference.docx \
    $CHAPTERS
echo DOCX built

pandoc \
    $METADATA \
    $TOC \
    -o $ODT_FILE \
    --reference-doc=templates/reference.odt \
    $CHAPTERS
echo ODT built
