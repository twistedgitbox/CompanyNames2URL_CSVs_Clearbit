#! /usr/bin/env ruby
require 'json'

file = File.read "./temp.json"
data = JSON.parse(file)
puts data
puts data.class
data.each do |key, val|
  puts "#{key} => #{val}" # prints each key and value.
  puts
end

