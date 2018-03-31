#! /usr/bin/env ruby

class LabeltoCleanList

  def init_lize(filename)
    File.open("#{filename}.csv", "w") {}
  end

  def list_from_file(filename)
    list = File.readlines(filename)
    return list
  end

  def read_labels(filename, label)
    self.init_lize(filename)
    list = self.list_from_file(filename)
    list.reject! { |e| e.to_s.empty? }
    list.uniq!
    #puts list
    self.read_in_labels(filename, label, list)
  end

  def clean(input)
    input.gsub(/^[\s]*$\n/, "").strip
  end

  def read_in_labels(filename, label, list)
    checkarrx = []
    labelsize = (label.length+1)
    puts "LENGTH #{labelsize} FOR #{label}"
    list.reject! { |item| item.nil? || item == '' }
    list.each do |line|
      if line.start_with?("#{label}:")
        puts "MATCH #{line}"
        line2 = line[labelsize..-1]
        line2 = line2.strip
        checkarrx << line2
      end
    end

    checkarrx.reject! { |item| item.nil? || item == '' }
    puts checkarrx

    newfile = "#{filename}.new"
    File.open(newfile, "w+") do |f|
      f.puts(checkarrx)
    end
    list == checkarrx
    return list
  end

  def list_run(filename, label)
    list = self.list_test(filename, label)
    puts list
    return list
  end

  def list_test(filename, label)
    list = self.read_labels(filename, label)
    return list
  end

end

#x = LabeltoCleanList.new

#x.list_run("StartList", "COMPANY")
#("StartList", "COMPANY")
#x.test_bad_companies
