require_relative 'lib/csv_processor_3_service.rb'
require_relative 'lib/csv_export_service.rb'

require 'pry'
require 'benchmark/ips'
require 'fastest-csv'
require 'parallel'

files = Dir["./datas/*.csv"]

binding.pry


#puts "4 CPUs -> work in 2 processes (a,b + c)"
#results = Parallel.map(files) do |file|
#       puts "Item: #{file}, Worker: #{Parallel.worker_number}"
#               structure = CsvProcessorService.new(file, structure).process
#end
#
#puts results
#puts "Structura"
#puts structure

#structure = {}
#puts "# 3 Processes -> finished after 1 run"
#results = Parallel.map(files, in_processes: 4) do |file|
#        puts "Item: #{file}, Worker: #{Parallel.worker_number}"
#        structure = CsvProcessorService.new(file, structure).process
#end
#
#puts results
#puts "STRUCTURE VALUES"
#puts structure



#structure = {}
#puts "# 4 Threads -> finished after 1 run"
#results = Parallel.map(files, in_threads: 4) do |file|
#        puts "Item: #{file}, Worker: #{Parallel.worker_number}"
#        structure = CsvProcessorService.new(file, structure).process
#end
#
#puts results
#puts "STRUCTURE VALUES"
#puts structure


# start_time_block = Time.now
# puts "# 3 Processes -> finished after 1 run"
processors = `nproc --all`
results = Parallel.map(files, in_processes: processors.to_i) do |file|
  puts "Item: #{file}, Worker: #{Parallel.worker_number}"
  CsvProcessor3Service.process(file)
end

# total_time_3 = Time.now.to_f - start_time_block.to_f
# puts "Tiempo total block 3: #{total_time_3}"

start_time_block = Time.now
new_structure_2 = {}
states = results.map {|result| result.keys }.flatten.uniq
states.each_with_index do |state, index|
  next if index == 0
  row_states = results.map {|result| result[state] }
  row_states.each_with_index do |row, index_2|
    if index_2 == 0
      new_structure_2[state] = row.dup
    else
      new_structure_2[state][:males] += row[:males]
      new_structure_2[state][:females] += row[:females]
      new_structure_2[state][:weight] += row[:weight]
      new_structure_2[state][1970][:birth] += row[1970][:birth]
      new_structure_2[state][1980][:birth] += row[1980][:birth]
      new_structure_2[state][1990][:birth] += row[1990][:birth]
      new_structure_2[state][2000][:birth] += row[2000][:birth]
      new_structure_2[state][1970][:race].merge(row[1970][:race]){ |k, b_value, a_value| a_value + b_value }
      new_structure_2[state][1980][:race].merge(row[1980][:race]){ |k, b_value, a_value| a_value + b_value }
      new_structure_2[state][1990][:race].merge(row[1990][:race]){ |k, b_value, a_value| a_value + b_value }
      new_structure_2[state][2000][:race].merge(row[2000][:race]){ |k, b_value, a_value| a_value + b_value }
    end
  end
end

CsvExportService.export(new_structure_2, 'datarace_parallel.csv')
total_time_3 = Time.now.to_f - start_time_block.to_f
puts "Tiempo total block 3: #{total_time_3}"
