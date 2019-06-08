require 'date'

module Meditions
  def print_memory_usage(description = '')
    puts "Medición #{description}"
    start_time = Time.now
    memory_before = `ps -o rss= -p #{Process.pid}`.to_i

    yield

    memory_after = `ps -o rss= -p #{Process.pid}`.to_i
    end_time = Time.now
    elapsed_seconds = (end_time.to_f - start_time.to_f)
    puts "#{description} | Tiempo total: #{elapsed_seconds}"
    puts "#{description} | Memory: #{((memory_after - memory_before) / 1024.0).round(2)} MB"
  end
end