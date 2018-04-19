#! /usr/bin/env ruby
require 'fileutils'

# This adds a label to the end of each file, while keeping the file extension.
# Format is in FILENAME_LABEL.EXT
# It reads from the RENAME folder and then saves in the COMPLETE folder

def new_name(fn, dest = './RENAME_FILES/COMPLETE/')

  # CHANGE THIS TO CHANGE THE LABEL
  append = 'e_learning'
  # CHANGE THIS TO CHANGE SEPARATOR
  append = append + '_'
  ext = File.extname(fn)
  File.join( dest, append + File.basename(fn, ext) + ext )
end

Dir[ './RENAME_FILES/RENAME/*' ].
select { |fn| File.file? fn }.
each   { |fn| FileUtils.cp fn, new_name(fn) }
FileUtils.rm Dir.glob('./RENAME_FILES/RENAME/*')
