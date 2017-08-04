require 'json'
require 'deep_merge'

json = Dir['data/*.json'].map { |f| JSON.parse(File.read(f)) }.flatten
File.open("data.json", "w+") {|f| f.write(JSON.pretty_generate(json.reduce(&:deep_merge))) }
