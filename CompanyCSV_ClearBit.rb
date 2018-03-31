#! /usr/bin/env ruby
require 'net/http'
require 'uri'
require 'csv'
require 'json'

require_relative 'LabelReader'

puts "CREATING CSV FROM LIST"

class NametoURL_CSV

  def init_lize(filename)
    File.open("#{filename}.csv", "w") {}
    label = "COMPANY"
    @arraylist = LabeltoCleanList.new
    @datafile = filename
    return label
  end


  def run(filename)
    label = self.init_lize(filename)
    listmade = @arraylist.list_run(filename, label)
    puts "THIS LIST #{listmade}"
    puts "DONE"
    #self.loop_through_array(listmade)
    #self.loop_through_companylist(newfile)
  end

  def test_bad_companies
    badtext = "Ya3R(DWv(iH^a5n>"
    self.get_clearbit(badtext)
  end

  def clean(input)
    input.gsub(/^[\s]*$\n/, "").strip
  end

  def loop_through_array(arr)
    arr.each do |line|
      line.strip!
      puts "THIS is #{line}"
      self.get_clearbit(line)
    end
  end

  def convert_JSON_to_CSV(textstring)
    objArray = JSON.parse(textstring)
    puts objArray
    puts objArray.class
    datafile = "#{@datafile}.csv"
    CSV.open(datafile, "a") do |csv|

      objArray.each do |hash|
        csv << hash.values
      end
    end
  end

  def get_clearbit(companyname)
    puts "ADDING: #{companyname}"
    uri = URI("https://autocomplete.clearbit.com/v1/companies/suggest?query=:#{companyname}")
    companyinfo = Net::HTTP.get(uri)
    sleep(0.5)
    puts companyinfo.class
    puts companyinfo
    self.convert_JSON_to_CSV(companyinfo)

  end
end

x = NametoURL_CSV.new

x.run("StartList")
#x.test_bad_companies