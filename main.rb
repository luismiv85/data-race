require './lib/csv_processor_service.rb'
require './modules/meditions.rb'
require 'pry'
require 'benchmark/ips'

include Meditions

files = Dir["./datas/*.csv"]

structure = {}

files.each do |file|
  puts '.'
  structure = CsvProcessorService.new(file, structure).process
end

puts structure