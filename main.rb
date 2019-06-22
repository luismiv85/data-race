require_relative 'lib/csv_processor_service.rb'
require_relative 'lib/csv_export_service.rb'
require_relative 'modules/meditions.rb'

require 'pry'
require 'benchmark/ips'
require 'fastest-csv'

files = Dir["./datas/*.csv"]

structure = {}
files.each do |file|
  CsvProcessorService.process(file, structure)
end

CsvExportService.export(structure, 'datarace.csv')
