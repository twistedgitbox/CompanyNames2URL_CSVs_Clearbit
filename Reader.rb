#! /usr/bin/env ruby
require 'net/http'
require 'uri'
require 'csv'
require 'json'

puts "CREATING CSV FROM LIST"

class NametoURL_CSV

  def initialize
    testbox = []
    ARGV.each do|a|
    testbox << "#{a}"
    end
    if testbox.count < 2 then
      puts "Please run filename and labeltype following run command as in './script.rb filename exportfile'"
      abort
    end
    filename = testbox[0]
    option = testbox[1]
    puts "FILENAME: #{filename}"
    puts "EXPORT: #{option}"
    @fileToexport = option
    label_info = self.label_run(filename, option)
    puts "Label Info is => #{label_info}"
    puts ; puts ; puts
    puts "Completed getting data from text file based on the labels added. Check Export folder for CSV #{filename}.csv."
  end

  def init_lize
    File.open("#{@fileToexport}_CompanyNamesURLs.csv", "w") {}
  end

  def blanklineremove(in_filename, out_filename)
    File.open(out_filename, "w") do |out_file|
      out_file.write clean(File.read(in_filename))
    end
  end

  def label_run(in_filename, out_filename)
    self.init_lize
    self.blanklineremove(in_filename, out_filename)
    puts "SAVING CLEAN DATA"
    self.read_array(out_filename)
    puts "READING COMPANIES FROM LIST"
    newfile = "CompanyNameList"
    self.read_in_companies(out_filename, newfile)
    puts "FILLING URL WITH COMPANY INFO FROM CLEARBIT"
    self.loop_through_companylist(newfile)
  end

  def test_bad_companies
    badtext = "Ya3R(DWv(iH^a5n>"
    self.get_clearbit(badtext)
  end

  def clean(input)
    input.gsub(/^[\s]*$\n/, "").strip
  end

  def read_array(file)
    fileName = file.to_s
    lines = File.readlines(fileName).uniq
    text = lines.join
    puts "ARRY" + text
    return
  end

  def loop_through_companylist(readfile)
    companyarr = []
    File.open(readfile).each do |line|
      puts "TEST#{line}"
      self.get_clearbit(line)
    end
  end

  def read_in_companies(fixedfile, newfile)
    checkarrx = []
    file = File.open(fixedfile, "r")
    companies = Hash.new []

    file.each_line do |line|
      if line.start_with?("COMPANY:")
        puts "MATCH #{line}"
        line2 = line[8..-1]
        line2 = line2.strip
        checkarrx << line2
      end
    end
    puts checkarrx
    File.open(newfile, "w+") do |f|
      f.puts(checkarrx)
    end
  end

  def convert_JSON_to_CSV(textstring)
    objArray = JSON.parse(textstring)
    puts objArray
    puts objArray.class
    datafile = "#{@fileToexport}_CompanyNamesURLs.csv"
    CSV.open(datafile, "a") do |csv|

      objArray.each do |hash|
        puts "HASH"
        hash[:sourcecompany] = "#{@companyname}"
        puts hash.values
        puts @companyname
        csv << hash.values
      end
    end
  end

  def get_clearbit(companyname)
    @companyname = companyname
    puts "ADDING: #{companyname}"
    uri = URI("https://autocomplete.clearbit.com/v1/companies/suggest?query=:#{companyname}")
    companyinfo = Net::HTTP.get(uri)
    puts companyinfo.class
    puts companyinfo
    self.convert_JSON_to_CSV(companyinfo)

  end
end

x = NametoURL_CSV.new

#x.run("StartList", "WorkingList")
#x.test_bad_companies
