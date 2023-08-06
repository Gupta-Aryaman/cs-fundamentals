
CHAPTER="$1"
PACKAGE="$2"

cat packages.csv | grep -i "^$PACKAGE" | grep -i -v "\.patch;" | while read line; do
    # NAME="`echo $line | cut -d\; -f1`"
    export VERSION="`echo $line | cut -d\; -f2`"
    URL="`echo $line | cut -d\; -f3 | sed "s/@/$VERSION/g"`"
    # MD5SUM="`echo $line | cut -d\; -f4`"
    CACHEFILE="$(basename "$URL")"
    DIRNAME="$(echo "$CACHEFILE" | sed 's/\(.*\)\.tar\..*/\1/')"  #remove .tar.* from the end of the filename

    mkdir -pv "$DIRNAME"
    echo "created $DIRNAME"
    echo "Extracting $CACHEFILE"
    tar -xf "$CACHEFILE" -C "$DIRNAME"

    #storing curr directory in a stack
    pushd "$DIRNAME"

    #if the extracted directory contains only one directory, move its contents to the parent directory 
    #this is done where for example I have binutils-2.25.1.tar.bz2 and it extracts to binutils-2.25.1 directory 
    if [ "$(ls -1A | wc -l)" == "1" ]; then
        mv $(ls -1A)/* ./
    fi

    echo "Compiling $PACKAGE"
    sleep 5

    mkdir -pv "../log/chapter$CHAPTER"
    if ! source "../chapter$CHAPTER/$PACKAGE.sh" 2>&1 | tee "../log/chapter$CHAPTER/$PACKAGE.log" ; then
        echo "COMPLING $PACKAGE FAILED!!!"
        popd
        exit 1
    fi

    echo "Done Compiling $PACKAGE"

    popd

done