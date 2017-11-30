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
        province "css=td.views-field-field-region-province-1>.item-list>ul>.last"
        municipality "css=td.views-field-field-municipality"
        school_name "css=td.views-field-field-school-name"
        programs "css=td.views-field-field-program-offerings" do |p|
          p.split(', ')
        end
        tvl_specializations "css=td.views-field-field-tvl-specializations" do |t|
          t.split(';')
        end
      end
    end
  end
end

scraper = K12SchoolScraper.new
school_data = {}

if File.directory?("aggregator/data")
  print "Data directory detected"
  (1..435).each do |page|
    puts "page: " + page.to_s
    filename = 'aggregator/data/' + page.to_s + '.json'
    data = scraper.scan(page)
    school_data = (page == 1 ? data : school_data.deep_merge(data))
    # puts school_data
    File.open(filename, "w+") {|f| f.write(JSON.pretty_generate(data)) }
  end
else
  raise "directory not found. create the folder first then try again."
end

