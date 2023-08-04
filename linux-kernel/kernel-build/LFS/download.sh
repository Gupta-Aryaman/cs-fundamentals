

cat packages.csv | while read line; do
    NAME="`echo $line | cut -d\; -f1`"
    VERSION="`echo $line | cut -d\; -f2`"
    URL="`echo $line | cut -d\; -f3 | sed "s/@/$VERSION/g"`"
    MD5SUM="`echo $line | cut -d\; -f4`"

    CACHEFILE="$(basename "$URL")"

    #all of this is done only if file isn't already there
    if [ ! -f "$CACHEFILE" ]; then
        echo Downloading $URL
        wget "$URL"
        
        #checking md5sum of downloaded file
        if ! echo "$MD5SUM $CACHEFILE" | md5sum -c >/dev/null; then
            echo "MD5SUM mismatch for $CACHEFILE"
            rm -f "$CACHEFILE"
            exit 1
        fi

    fi

    

done