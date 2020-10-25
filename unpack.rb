# unpack.rb
#
# Author: Rea
#
# A utility for unpacking .tpk files, utilized by the 7th Dragon 2020 games.
# May also be used in other Imageepoch PSP titles, I'm not entirely sure.
#
# This file, like the rest of EnemyTool, is licensed under the MIT License.
# You can find the text and stipulations of the MIT License in the LICENSE
# file at the root of the repository.

require 'fileutils'

TPK_FILE_IDENTIFIER = 0x0004841C

# main
tpk_filename = ARGV[0]

if tpk_filename == nil then
  puts "TPK filename is missing. Must be first argument after unpack.rb."
  exit
end

if (File.exist?(tpk_filename) == false) then
  puts "The TPK filename provided doesn't exist."
  exit
end

if (File.directory?(tpk_filename) == true) then
  puts "The path provided for the TPK is a directory."
  exit
end

File.open(tpk_filename, 'rb') do |input|
  file_identifier = input.read(4).unpack('I<').first
  if file_identifier != TPK_FILE_IDENTIFIER then
    puts "The provided file is not a TPK."
    exit
  end
  num_files = input.read(4).unpack('I<').first
  locations = []
  filenames = []
  num_files.times do |file_index|
    input.seek(0x8 + (0x20 * file_index), :SET)
    locations.append(input.read(4).unpack('I<').first)
    filenames.append(input.read(0x1C).gsub("\0", ''))
  end
  output_dir = File.basename(tpk_filename, '.tpk')
  FileUtils.mkdir_p("#{output_dir}")
  locations.length.times do |file_index|
    location = locations[file_index]
    filename = filenames[file_index]
    length = 0
    if file_index < (locations.length - 1) then
      length = locations[file_index + 1] - location
    else
      length = input.size - location
    end
    File.open(File.join(output_dir, filename), 'wb') do |output|
      input.seek(location, :SET)
      output.write(input.read(length))
    end
  end
end