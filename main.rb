working_dir = Dir.pwd
Dir.chdir __dir__
require 'git'
require 'pry'
require './brancher.rb'
Dir.chdir working_dir

brancher = Brancher.new
brancher.branch ARGV[0], ARGV[1]