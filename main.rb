require './lib/data_service.rb'
require './lib/csv_processor_service.rb'
require './modules/file_name.rb'
require './modules/meditions.rb'
require 'pry'
require 'benchmark/ips'

include FileName
include Meditions

files = Dir["./datas/*.csv"]
binding.pry
structure = {}

files.each do |file|
  puts '.'
  structure = CsvProcessorService.new(file, structure).process
end

puts structure