class CsvProcessorService
  def initialize(file, structure)
    @file = file
    @structure = structure
  end

  def process
    FastestCSV.foreach(@file) do |row|
      # next if row[5].nil?
      state = row[5].to_sym rescue next
      next if state == :state

      @structure[state] ||= initialize_struct
      year = row[0].to_i
      decade = year - (year % 10)

      begin
        @structure[state][decade][:birth] += 1
      rescue
        @structure[state][decade] = { birth: 1 }
        RACES.each { |key, value| @structure[state][decade][key] = 0 }
      end

      # Raza
      (@structure[state][decade][row[7]] += 1) rescue nil

      if row[6] == 'true'
        @structure[state][:males] += 1
      else
        @structure[state][:females] += 1
      end
      @structure[state][:weight] += row[8].to_f
    end

    return @structure
  end

  private

  def initialize_struct
    {
      males: 0,
      females: 0,
      weight: 0
    }
  end
end