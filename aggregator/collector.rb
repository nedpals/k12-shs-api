require 'json'
require 'json/minify'
require 'deep_merge'

json = Dir['data/*.json'].map { |f| JSON.parse(File.read(f).force_encoding("UTF-8")) }.flatten
File.open("db.json", "w+") do |f| 
	f.write(
		JSON.minify(
			JSON.pretty_generate(
				json.reduce(&:deep_merge)
			)
		)
	)
end
