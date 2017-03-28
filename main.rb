require 'git'
require 'pry'
require './brancher'

brancher = Brancher.new
brancher.branch ARGV[0], ARGV[1]