#!/bin/sh


GenerateX2X1PNG()
{

    if [[ "$1" =~ .*@3x\.png ]] ;then
    imageHeight=`sips -g pixelHeight $1 | awk -F: '{print $2}'`
    imageWidth=`sips -g pixelWidth $1 | awk -F: '{print $2}'`
    height=`echo $imageHeight`
    width=`echo $imageWidth`
    height1x=$(($height/3))
    width1x=$(($width/3))
    fileName1x=${2/@3x\.png/\.png}
    height2x=$(($height1x*2))
    width2x=$(($width1x*2))
    fileName2x=${2/@3x\.png/\@2x.png}
    sips -z $height1x $width1x $1 --out $fileName1x
    sips -z $height2x $width2x $1 --out $fileName2x
    fi

}
GenerateFloder()
{
    cd $1
    for file in "$1"/*
    do

        imageFile=$(basename $file)
        if [ -d $imageFile ]; then

        #文件夹
        floder=$2/$imageFile
        mkdir $floder

        GenerateFloder $1/$imageFile $2/$imageFile
        cd $1
        else
        GenerateX2X1PNG  $1/$imageFile $2/$imageFile
        fi

    done
}
#$1 源文件夹  $2目标文件夹
rm -r $2
mkdir $2
GenerateFloder $1 $2
