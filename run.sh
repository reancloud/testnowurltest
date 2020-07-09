#!/bin/bash

# unzip vendor.zip
# if [[ ! -e .bundle ]]; then
#             mkdir .bundle
# fi

 bundle install && bundle exec cucumber features/urlcrawl.feature -p selenium --format pretty --format json --out=report/features_report.json --format Formatter::HtmlFormatter --out=report/features_report.html

