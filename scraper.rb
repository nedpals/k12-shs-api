require 'wombat'
require 'deep_merge'
require 'json'
class K12SchoolScraper
  def scan(page_num)
    Wombat.crawl do
      base_url "http://www.deped.gov.ph"
      path "/k-to-12/shs?page=#{page_num}"

      schools "css=table.views-table>tbody>tr.row", :iterator do
        school_id "css=td.views-field-field-school-id"
        region "css=td.views-field-field-region-province"
        province "css=td.views-field-field-region-province-1"
        municipality "css=td.views-field-field-municipality"
        school_name "css=td.views-field-field-school-name"
        programs "css=td.views-field-field-program-offerings"
        tvl_specializations "css=td.views-field-field-tvl-specializations" do |t|
          t.split(';')
        end
      end
    end
  end
end

scraper = K12SchoolScraper.new
school_data = {}
(1..432).each do |page|
  puts "page: " + page.to_s
  filename = 'data/' + page.to_s + '.json'
  data = scraper.scan(page)
  school_data = (page == 1 ? data : school_data.deep_merge(data))
  puts school_data
  File.open(filename, "w+") {|f| f.write(JSON.pretty_generate(data)) }
end

json = Dir['data/*.json'].map { |f| JSON.parse(File.read(f)) }.flatten
File.open("data.json", "w+") {|f| f.write(JSON.generate(json.reduce(&:deep_merge))) }