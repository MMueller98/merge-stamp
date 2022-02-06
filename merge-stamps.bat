@ECHO OFF
cd ./InputStamps

ECHO "==============================================================="
ECHO "Converting .pdf stamps to jpg-files"
ECHO "==============================================================="
ECHO: 

FOR %%i IN (*.pdf) DO (
	magick convert -verbose -density 150 -trim %%i -quality 100 -flatten -sharpen 0x1.0 -append %%i.jpg
	move %%i ../processed/%%i
)

ECHO "==============================================================="
ECHO "Concatenate single stamps into one jpg-file -> stamps.jpg"
ECHO "==============================================================="
ECHO: 

magick montage -mode concatenate -tile 2x -crop 500x350+0+0 *.jpg ../stamps.jpg

DEL *.jpg
cd ..