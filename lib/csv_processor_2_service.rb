class CsvProcessor2Service
  def initialize(file, structure)
    @file = file
    @structure = structure
  end

  def process
    FastestCSV.foreach(@file) do |row|
      next if row[5].nil?
      @structure[row[5]] ||= initialize_struct
      year = row[0].to_i
      decade = year / 10 * 10

      begin
        @structure[row[5]][decade][:birth] += 1
      rescue
        @structure[row[5]][decade] = { birth: 1 }
        RACES.each { |race| @structure[row[5]][decade][race[0]] = 0 }
      end

      # Raza
      (@structure[row[5]][decade][row[7]] += 1) rescue nil

      if row[6] == 'true'
        @structure[row[5]][:males] += 1
      else
        @structure[row[5]][:females] += 1
      end
      @structure[row[5]][:weight] += row[8].to_f
    end
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