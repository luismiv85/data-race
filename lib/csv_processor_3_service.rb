class CsvProcessor3Service
  def initialize; end

  def self.process(file, structure = {})
    FastestCSV.foreach(file) do |row|
      if structure[row[5]].nil?
        if row[5].nil?
          next
        else
          structure[row[5]] = { males: 0, females: 0, weight: 0 }
        end
      end

      decade = row[0].to_i / 10 * 10
      next if decade == 1960

      # Births per decade
      begin
        structure[row[5]][decade][:birth] += 1
      rescue
        structure[row[5]][decade] = { birth: 1, race: {} }
      end

      # Race per decade
      begin
        structure[row[5]][decade][:race][row[7]] += 1
      rescue
        structure[row[5]][decade][:race][row[7]] = 1
      end

      if row[6] == 'true'
        structure[row[5]][:males] += 1
      else
        structure[row[5]][:females] += 1
      end

      # structure[row[5]][GENDER[row[6]]] += 1
      structure[row[5]][:weight] += row[8].to_f
    end

    return structure
  end
end
