require_relative 'lib/csv_processor_service.rb'
require_relative 'lib/csv_processor_2_service.rb'
require_relative 'lib/csv_processor_3_service.rb'
require_relative 'lib/csv_export_service.rb'
require_relative 'modules/meditions.rb'

require 'pry'
require 'benchmark/ips'
require 'fastest-csv'

include Meditions

files = Dir["./datas/*.csv"]

structure = {}
# start_time_block = Time.now
files.each do |file|
  # start_time = Time.now
  CsvProcessor3Service.process(file, structure)
  # end_time = Time.now
  # puts "Tiempo 3: #{end_time.to_f - start_time.to_f}"
end
CsvExportService.export(structure, 'datarace.csv')
# total_time_3 = Time.now.to_f - start_time_block.to_f
# puts "Tiempo total block 3: #{total_time_3}"


