@ECHO OFF
cd ./InputStamps

ECHO "==============================================================="
ECHO "Converting .pdf stamps to jpg-files"
ECHO "==============================================================="
ECHO: 

SET IMAGECOUNTER=0

FOR %%i IN (*.pdf) DO (
	magick convert -verbose -density 300x300 -trim %%i -quality 100 -flatten -sharpen 0x1.0 -append %%i.png
	move %%i ../processed/%%i
	set /A IMAGECOUNTER=IMAGECOUNTER+1
)

FOR /l %%j IN (%IMAGECOUNTER%, 1, 9) DO (
	Copy ..\Installation\white.png "zz%%j.png"
)

ECHO "==============================================================="
ECHO "Concatenate single stamps into one png-file -> stamps.png"
ECHO "==============================================================="
ECHO: 

magick montage -verbose -density 300x300 -mode concatenate -tile 2x -crop 1240x701+0+0 *.png ../stamps.png

DEL *.png
MOVE *.pdf ../Processed
cd ..

magick convert -density 72 -page a4 stamps.png multipage.pdf
