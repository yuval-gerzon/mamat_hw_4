#!/bin/bash

wget https://www.ynetnews.com/category/3082
##getting the articles
grep -E "https:\/\/www.ynetnews.com\/article\/[A-Z,a-z,0-9]{9}" 3082 -o \
|sort -u > links.txt

cat links.txt |wc -l > results.csv

cat links.txt |xargs -n 1 wget -P ./articles 
##finding and counting occurrences of both names
for article_indx in `ls ./articles`; do
    N=`cat ./articles/$article_indx |grep "Netanyahu" -o | wc -l`
    G=`cat ./articles/$article_indx |grep "Gantz" -o | wc -l`
	##saving results
    echo -n "https://www.ynetnews.com/article/$article_indx, " >> results.csv
    if [[ $N == 0 ]] && [[ $G == 0 ]]; then
        echo - >> results.csv
        continue
    fi

    echo -n "Netanyahu, $N, " >> results.csv
    echo "Gantz, $G" >> results.csv
done

rm 3082
rm links.txt
rm -rf ./articles
