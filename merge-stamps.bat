@ECHO OFF
cd ./InputStamps

ECHO "==============================================================="
ECHO "Converting .pdf stamps to jpg-files"
ECHO "==============================================================="
ECHO: 

FOR %%i IN (*.pdf) DO (
	magick convert -verbose -density 300x300 -trim %%i -quality 100 -flatten -sharpen 0x1.0 -append %%i.png
	move %%i ../processed/%%i
)

ECHO "==============================================================="
ECHO "Concatenate single stamps into one png-file -> stamps.png"
ECHO "==============================================================="
ECHO: 

magick montage -verbose -density 300x300 -mode concatenate -tile 2x -crop 1200x875+0+0 *.png ../stamps.png

DEL *.png
cd ..

magick convert stamps.png -resize 1240x1753 -units PixelsPerInch -density 150x150 -page a4 multipage.pdf

