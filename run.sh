#!/bin/bash

 bundle install && bundle exec cucumber features/urlcrawl.feature -p selenium --format pretty --format json --out=report/features_report.json --format Formatter::HtmlFormatter --out=report/feature-overview.html

