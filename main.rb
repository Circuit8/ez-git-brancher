require 'git'
require 'pry'
require './brancher'

brancher = Brancher.new
brancher.branch ARGV[0]