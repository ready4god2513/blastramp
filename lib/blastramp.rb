$LOAD_PATH << File.expand_path(File.join(*%w[ .. lib ]), File.dirname(__FILE__))
require 'savon'
require 'ext'
require 'blastramp/inventory_count'
require 'blastramp/inventory_count_query'
require 'blastramp/session'

module Blastramp
end
