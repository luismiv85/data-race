require_relative 'lib/data_service.rb'

task default: %w[setup]

task :setup do
  DataService.new(
    path_to_download: 'benchmarks/data'
  ).download_file('gs://securitas/natalidad000000000000.csv')

  DataService.new(path_to_download: 'datas/').download_all_files
end