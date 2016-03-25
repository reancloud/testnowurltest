BDD Scenarios 
========================

## Install

1. Start memcash[D:\Tools\CitrusPayTools\Setups\memcached-win64]
2. Start redis'.[D:\Tools\CitrusPayTools\Setups\redis-2.4.5-win32-win64\64bit\redis-server]
3. In eclipse start ssl page.
4. Start citrus-pay mock server


Your description to install project
gem update --system 2.3.0
            $ bundle install 
 Make sure you are using correct ruby version.

## Usage

### Run cucumber bundle tasks

             $ bundle exec cucumber -p selenium
             
### Run Rake tasks

             $ bundle exec rake [task name]

rake features
rake parallel:features

## Running on CI


Your steps to run the things on CI goes here


