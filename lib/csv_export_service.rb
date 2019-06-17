require 'csv'

RACES = {
  '48' => 'Vietnamese',
  '6'  => 'Hawaiian',
  '4'  => 'Chinese',
  '39' => 'Samoan',
  '2'  => 'Black',
  '9'  => 'Unknown/Other',
  '28' => 'Korean',
  '18' => 'Asian Indian',
  '5'  => 'Japanese',
  '1'  => 'White',
  '3'  => 'American Indian',
  '7'  => 'Filipino'
}

class CsvExportService
  def initialize; end

  def self.export(structure, csv_file_path)
    CSV.open(csv_file_path, "w") do |csv|
      csv << ['state','B70','B80','B90','B00','Race70', 'Race80', 'Race90', 'Race00', 'Male', 'Female', 'Weight']
      structure.each do |state|
        next if state[0] == "state"
        csv << [
          state[0],
          state[1][1970][:birth],
          state[1][1980][:birth],
          state[1][1990][:birth],
          state[1][2000][:birth],
          RACES[state[1][1970][:race].compact.max_by{|k,v| v}[0]],
          RACES[state[1][1980][:race].compact.max_by{|k,v| v}[0]],
          RACES[state[1][1990][:race].compact.max_by{|k,v| v}[0]],
          RACES[state[1][2000][:race].compact.max_by{|k,v| v}[0]],
          state[1][:males],
          state[1][:females],
          state[1][:weight] / (state[1][:females] + state[1][:males])
        ]
      end
    end
  end
end
