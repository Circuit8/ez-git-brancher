require 'git'
require './brancher'

brancher = Brancher.new ARGV[1]
brancher.branch ARGV[0]