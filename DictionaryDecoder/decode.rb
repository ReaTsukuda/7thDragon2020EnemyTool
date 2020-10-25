# decode.rb
#
# Author: Rea
#
# Decodes the 2020 and 2020-II dictionary text encoding; specifically,
# it takes the decimal representation of ASCII characters and converts
# them into the actual ASCII characters.
#
# Licensed under the MIT license. See the LICENSE file in the root of
# the repository.

# main
File.open('EncodingOutput2020.csv', 'w') do |output|
  File.readlines('EncodingInput2020.csv').each do |encoding|
    encoding_split = encoding.split(',')
    first_char = encoding_split[0].to_i.chr
    second_char = encoding_split[1].to_i.chr
    encoding = encoding_split[2]
    output.puts "#{encoding.strip},#{first_char}#{second_char}"
  end
end