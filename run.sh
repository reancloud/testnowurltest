#!/bin/bash

unzip vendor.zip
if [[ ! -e .bundle ]]; then
            mkdir .bundle
fi

 bundle install --local && cucumber features/urlcrawl.feature -p selenium --format pretty --format json --out=report/features_report.json --format Formatter::HtmlFormatter --out=report/features_report.html

