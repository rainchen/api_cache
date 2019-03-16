require "rspec"
require 'webmock/rspec'

$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require "api_cache"

APICache.logger.level = Logger::FATAL

require "pry-byebug" # allow to use "binding.pry" to debug
require "shared_store_specs"
