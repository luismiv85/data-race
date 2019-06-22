require_relative 'lib/csv_processor_service.rb'
require_relative 'lib/csv_export_service.rb'

require 'pry'
require 'benchmark/ips'
require 'fastest-csv'
require 'parallel'

files = Dir["./datas/*.csv"]

start_time_block = Time.now
puts "Working #{`nproc --all`} porcesadores"
results = Parallel.map(files) do |file|
  CsvProcessorService.process(file)
end

structure = {}
states = results.map {|result| result.keys }.flatten.uniq

states.each_with_index do |state, index|
  next if index == 0
  row_states = results.map {|result| result[state] }
  row_states.each_with_index do |row, index_2|
    if index_2 == 0
      structure[state] = row.dup
    else
      structure[state][:males] += row[:males]
      structure[state][:females] += row[:females]
      structure[state][:weight] += row[:weight]
      structure[state][1970][:birth] += row[1970][:birth]
      structure[state][1980][:birth] += row[1980][:birth]
      structure[state][1990][:birth] += row[1990][:birth]
      structure[state][2000][:birth] += row[2000][:birth]
      structure[state][1970][:race].merge(row[1970][:race]){ |k, b_value, a_value| a_value + b_value }
      structure[state][1980][:race].merge(row[1980][:race]){ |k, b_value, a_value| a_value + b_value }
      structure[state][1990][:race].merge(row[1990][:race]){ |k, b_value, a_value| a_value + b_value }
      structure[state][2000][:race].merge(row[2000][:race]){ |k, b_value, a_value| a_value + b_value }
    end
  end
end

CsvExportService.export(structure, 'datarace_parallel.csv')
puts "Tiempo total block 1: #{Time.now.to_f - start_time_block.to_f}"
