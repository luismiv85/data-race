require 'benchmark/ips'
require 'pry'
require './data/dataset_vars.rb'
require '../modules/meditions.rb'

require 'ccsv'
require 'compact_csv'
require 'fastest-csv'
require 'import_csv'
require 'rcsv'
require 'csv'

include Meditions

# Benchmark.ips do |x|
#   x.config(
#     :stats => :bootstrap,
#     :confidence => 95,
#     :time => 5,
#     :warmup => 2
#   )

#   x.report('RCSV gem       ->') {
#     file = File.open("#{FILE}")
#     i = 0
#     # Rcsv.parse(file, :header => :skip, :columns => { 0 => { :type => :int }, 8 => { type: :float }}) { |row|
#     Rcsv.parse(file) { |row|  i += 1 }
#     file.close
#   }

#   x.report('CCSV gem       ->') {
#     i = 0
#     Ccsv.foreach("#{FILE}") { |row| i += 1 }
#   }

#   x.report('FastestCSV gem ->'){
#     i = 0
#      FastestCSV.foreach("#{FILE}") do |row| i += 1; end
#   }

#   x.report('ImportCSV gem  ->'){
#     i = 0
#     ImportCSV.new("#{FILE}") do |line| i += 1; end
#   }

#   x.report('CompactCSV gem ->'){
#     csv = CompactCSV.read("#{FILE}", headers: true)
#     i = 0
#     csv.each do |row| i += 1; end
#   }

#   # x.report('CSV core ruby  ->'){
#   #   i = 0
#   #   CSV.foreach("#{FILE}", headers: false) do |row| i += 1; end
#   # }

#   x.compare!
# end


Benchmark.ips do |x|
  x.config(
    :time => 5,
    :warmup => 2
  )

  x.report('string') {
    x = {}
    year = '1989'
    x[year] = 1

    100.times do
      x[year]
    end
  }

  x.report('integer') {
    x = {}
    year = '1989'.to_i
    decade = year - (year % 10)
    x[decade] = 1
    100.times do
      x[decade]
    end
  }

  x.compare!
end

Benchmark.ips do |x|
  x.config(
    :time => 10,
    :warmup => 2
  )

  x.report('rescue') {
    x = {}
    year = '1989'.to_i
    decade = year - (year % 10)

    1000.times do
      begin
        x[decade][12] += 1
      rescue
        x[decade] = {12 => 0}
        x[decade][12] += 1
      end
    end
  }

  x.report('|| operation') {
    x = {}
    year = '1989'.to_i
    decade = year - (year % 10)

    1000.times do
      x[decade] ||= {12 => 0}
      x[decade][12] += 1
    end
  }

  x.compare!
end


Benchmark.ips do |x|
  x.config(
    :time => 10,
    :warmup => 2
  )

  x.report('i += 1') {
    i = 0
    2000000.times do
      i += 1
    end
  }

  x.report('i = i + 1') {
    i = 0
    2000000.times do
      i = i + 1
    end
  }

  x.compare!
end

Benchmark.ips do |x|

  structure = {}
  x.config(
    :time => 10,
    :warmup => 2
  )

  x.report('structure[:i] += 1') {
    structure = {i: 0}

    2000000.times do
      structure[:i] += 1
    end
  }

  x.report('structure[:i] = structure[:i] + 1') {
    structure = {i: 0}

    2000000.times do
      structure[:i] = structure[:i] + 1
    end
  }

  x.compare!
end

