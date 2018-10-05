#!/bin/sh
home=$(pwd)
zip -r urltest.zip . -x *.git*
echo "Zip artifact for ruby url automation code is created." 
