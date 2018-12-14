#!/bin/sh
home=$(pwd)
zip -r urltest_runCrawl.zip . -x *.git*
echo "Zip artifact for ruby url automation code with crawling is created." 

