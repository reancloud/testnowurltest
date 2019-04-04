#!/bin/sh
home=$(pwd)
zip -r urltest-crawl-$1.zip . -x *.git*
echo "Zip artifact for ruby url automation code with crawling is created." 
