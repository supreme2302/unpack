#!/bin/bash

function extract() {
    if [[ "${1##*.}" == "zip" ]]
    then
        unzip $1 && eval $2 && cd ${1/.*/}
        for f in `find . -maxdepth 1 -iname *.zip`; do 
            mv "$f" ../; 
        done
        for f in `find . -maxdepth 1 -iname *.tar`; do
            mv "$f" ../;
        done
    else
        tar -xvf $1 && eval $2 && cd ${1/.*/}
        for f in `find . -maxdepth 1 -iname *.zip`; do 
            mv "$f" ../; 
        done
        for f in `find . -maxdepth 1 -iname *.tar`; do
            mv "$f" ../;
        done
    fi

    ANSWER=$(ls | grep "answer.txt")
    if [ ! -z "$ANSWER" -a "$ANSWER" != " " ]; then
        cat "answer.txt";
        return 0; 
    fi

    cd ../
    rm "$1"
    rm -r ${1/.*/}

    for zip in `find . -maxdepth 1 -iname *.zip`; do
        extract "${zip##./}"
    done
    for tar in `find . -maxdepth 1 -iname *.tar`; do
        extract $"${tar##./}"
    done
}

extract '447509d6ee8b4cbaa96e3153ddddd7ba.zip'
# extract '32db1e4a207b4e409d43d8bbde6cbe83.zip'