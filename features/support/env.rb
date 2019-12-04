require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'cucumber'
require 'rake'
#require 'headless'


include RSpec::Matchers

require File.dirname(__FILE__) + "/utilities"
require File.dirname(__FILE__) + "/driver_config"
include URLTest
require File.dirname(__FILE__) + "/../../features/pages/gmail_info_page"




