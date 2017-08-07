require 'json'
require 'deep_merge'

json = Dir['data/*.json'].map { |f| JSON.parse(File.read(f).force_encoding("UTF-8")) }.flatten
File.open("db.json", "w+") {|f| f.write(JSON.pretty_generate(json.reduce(&:deep_merge))) }
