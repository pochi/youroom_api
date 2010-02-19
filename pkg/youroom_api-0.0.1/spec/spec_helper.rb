$KCODE= 'u'
require 'rubygems'
require 'spec'

$LOAD_PATH << File.expand_path("..", File.dirname(__FILE__))
$LOAD_PATH << File.expand_path("../lib", File.dirname(__FILE__))

load File.expand_path("setup_test_model.rb", File.dirname(__FILE__))
