#! /usr/bin/env ruby
require 'fileutils'

# This adds a label to the end of each file, while keeping the file extension.
# Format is in FILENAME_LABEL.EXT
# It reads from the RENAME folder and then saves in the COMPLETE folder

def new_name(fn, dest = './COMPLETE/')

  # CHANGE THIS TO CHANGE THE LABEL
  append = 'e_learning'
  # CHANGE THIS TO CHANGE SEPARATOR
  append = '_' + append
  ext = File.extname(fn)
  File.join( dest, File.basename(fn, ext) + append + ext )
end

Dir[ './RENAME/*' ].
select { |fn| File.file? fn }.
each   { |fn| FileUtils.cp fn, new_name(fn) }
