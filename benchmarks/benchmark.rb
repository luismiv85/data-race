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

Benchmark.ips do |x|
  x.config(
    :stats => :bootstrap,
    :confidence => 95,
    :time => 5,
    :warmup => 2
  )

  def x(structure = {})
    structure[1] = 0
    1000.times do
      structure[1] += 1
    end
    return structure
  end

  x.report('with reference') {
    structure = {}
    1000.times do
      x(structure)
    end
  }

  x.report('no reference') {
    1000.times do
      x
    end
  }

  x.compare!
end


Benchmark.ips do |x|
  x.config(time: 10)

  GENDER = {
    'true' => :males,
    'false' => :females
  }

  array = ['true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true', 'true',
    'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false', 'false',
    'otro', 'otro', 'otro', 'otro', 'otro', 'otro', 'otro', 'otro', 'otro', 'otro']

  x.report('compare if == string') {
    1000.times do
      array.each do |value|
        if value == 'true'
          :males
        else
          :females
        end
      end
    end
  }

  x.report('search in hash faster') {
    1000.times do
      array.each do |value|
        GENDER[value] rescue nil
      end
    end
  }

  x.compare!
end

Benchmark.ips do |x|
  x.config(time: 10)

  x.report('hash assing = {} faster') {
    1000.times do
      x = {}
      x[:test] = { males: 0, females: 0, weight: 0, 1970 => { birth: 0 }, 1980 => { birth: 0 }, 1990 => { birth: 0 }, 2000 => { birth: 0 } }
    end
  }

  x.report('hash assing hash[]') {
    1000.times do
      x = {}
      x[:test] = {}
      x[:test][:males] = 0
      x[:test][:females] = 0
      x[:test][:weight] = 0
      x[:test][1970] = {}
      x[:test][1970][:birth] = 0
      x[:test][1980] = {}
      x[:test][1980][:birth] = 0
      x[:test][1990] = {}
      x[:test][1990][:birth] = 0
      x[:test][2000] = {}
      x[:test][2000][:birth] = 0
    end
  }

  x.compare!
end


Benchmark.ips do |x|
  x.config(time: 10)

  x.report('increment or create rescue') {
    100.times do
      x = { test: 1 }
      begin
        x[:test] += 1
      rescue
        x[:test] = { 1 => 1 }
      end
    end

    100.times do
      x = {}
      begin
        x[:test] += 1
      rescue
        x[:test] = { 1 => 1 }
      end
    end
  }

  x.report('increment or create if nil? faster') {
    100.times do
      x = { test: 1 }
      if x[:test].nil?
        x[:test] = { 1 => 1 }
      else
        x[:test] += 1
      end
    end

    100.times do
      x = {}
      if x[:test].nil?
        x[:test] = { 1 => 1 }
      else
        x[:test] += 1
      end
    end
  }

  x.compare!
end


structure = {"state"=>{:males=>0, :females=>3, :weight=>0.0, 0=>{:birth=>3}},
 nil=>{:males=>378093, :females=>360579, :weight=>5311055.446076263, 2000=>{:birth=>738672}},
 "AK"=>{:males=>7186, :females=>6795, :weight=>105818.93817955737, 2000=>{:birth=>2143}, 1970=>{:birth=>2234}, 1980=>{:birth=>4924}, 1990=>{:birth=>4526}, 1960=>{:birth=>154}},
 "CA"=>{:males=>307865, :females=>292822, :weight=>4443899.579515615, 1970=>{:birth=>72956}, 1980=>{:birth=>157608}, 1990=>{:birth=>245414}, 2000=>{:birth=>116988}, 1960=>{:birth=>7721}},
 "HI"=>{:males=>12642, :females=>11608, :weight=>173988.81496575993, 1960=>{:birth=>367}, 1970=>{:birth=>3891}, 1980=>{:birth=>7932}, 1990=>{:birth=>8162}, 2000=>{:birth=>3898}},
 "IL"=>{:males=>134071, :females=>128057, :weight=>1915806.840562896, 1990=>{:birth=>80178}, 1970=>{:birth=>60590}, 2000=>{:birth=>39096}, 1960=>{:birth=>4272}, 1980=>{:birth=>77992}},
 "MD"=>{:males=>45737, :females=>43343, :weight=>649283.7164629288, 1980=>{:birth=>26607}, 1960=>{:birth=>1285}, 1970=>{:birth=>16009}, 1990=>{:birth=>30034}, 2000=>{:birth=>15145}},
 "MN"=>{:males=>47442, :females=>44963, :weight=>692573.2012120762, 2000=>{:birth=>14820}, 1960=>{:birth=>1398}, 1970=>{:birth=>18542}, 1980=>{:birth=>29203}, 1990=>{:birth=>28442}},
 "MO"=>{:males=>59236, :females=>56419, :weight=>848274.3651022929, 1980=>{:birth=>34099}, 1970=>{:birth=>28784}, 1960=>{:birth=>1752}, 1990=>{:birth=>34273}, 2000=>{:birth=>16747}},
 "NY"=>{:males=>192754, :females=>183139, :weight=>2729565.5016522724, 1990=>{:birth=>119252}, 1980=>{:birth=>112444}, 2000=>{:birth=>55544}, 1960=>{:birth=>6662}, 1970=>{:birth=>81991}},
 "OH"=>{:males=>115142, :females=>109223, :weight=>1643897.6065124357, 1960=>{:birth=>4227}, 1980=>{:birth=>70568}, 1970=>{:birth=>47755}, 1990=>{:birth=>68566}, 2000=>{:birth=>33249}},
 "PA"=>{:males=>109195, :females=>103770, :weight=>1560075.561692926, 1970=>{:birth=>38452}, 2000=>{:birth=>31582}, 1960=>{:birth=>4076}, 1980=>{:birth=>70741}, 1990=>{:birth=>68114}},
 "UT"=>{:males=>28509, :females=>27022, :weight=>405811.9492741354, 2000=>{:birth=>10950}, 1980=>{:birth=>17283}, 1960=>{:birth=>525}, 1970=>{:birth=>8933}, 1990=>{:birth=>17840}},
 "WA"=>{:males=>49821, :females=>47428, :weight=>731447.574220651, 2000=>{:birth=>17452}, 1970=>{:birth=>14519}, 1980=>{:birth=>30345}, 1990=>{:birth=>33661}, 1960=>{:birth=>1272}},
 "WI"=>{:males=>50977, :females=>48811, :weight=>746837.7228558953, 1970=>{:birth=>22212}, 2000=>{:birth=>14796}, 1960=>{:birth=>1579}, 1980=>{:birth=>31565}, 1990=>{:birth=>29636}},
 "CT"=>{:males=>30024, :females=>28712, :weight=>432141.96004995186, 1980=>{:birth=>18807}, 1960=>{:birth=>1070}, 1970=>{:birth=>9345}, 1990=>{:birth=>20003}, 2000=>{:birth=>9511}},
 "GA"=>{:males=>68960, :females=>64833, :weight=>963326.0996721747, 2000=>{:birth=>29817}, 1960=>{:birth=>1966}, 1970=>{:birth=>18968}, 1980=>{:birth=>32488}, 1990=>{:birth=>50554}},
 "IN"=>{:males=>59461, :females=>56775, :weight=>855438.3480353039, 1960=>{:birth=>2113}, 1970=>{:birth=>22878}, 1980=>{:birth=>35647}, 1990=>{:birth=>36840}, 2000=>{:birth=>18758}},
 "KY"=>{:males=>39375, :females=>37442, :weight=>563692.8588225015, 1980=>{:birth=>23523}, 2000=>{:birth=>11501}, 1960=>{:birth=>1294}, 1970=>{:birth=>17679}, 1990=>{:birth=>22820}},
 "MI"=>{:males=>104985, :females=>99709, :weight=>1501489.869482393, 1970=>{:birth=>51858}, 1960=>{:birth=>3533}, 1980=>{:birth=>60609}, 1990=>{:birth=>60414}, 2000=>{:birth=>28280}},
 "NC"=>{:males=>72306, :females=>68961, :weight=>1024081.9319997934, 2000=>{:birth=>26029}, 1960=>{:birth=>2014}, 1970=>{:birth=>27950}, 1980=>{:birth=>39243}, 1990=>{:birth=>46031}},
 "NV"=>{:males=>14233, :females=>13437, :weight=>200227.5058634974, 1980=>{:birth=>6810}, 1970=>{:birth=>2899}, 1990=>{:birth=>10737}, 2000=>{:birth=>7026}, 1960=>{:birth=>198}},
 "RI"=>{:males=>10567, :females=>9876, :weight=>149596.8504564818, 2000=>{:birth=>3004}, 1960=>{:birth=>363}, 1970=>{:birth=>4862}, 1980=>{:birth=>5950}, 1990=>{:birth=>6264}},
 "TX"=>{:males=>222588, :females=>212415, :weight=>3168492.9484159416, 1970=>{:birth=>71981}, 1990=>{:birth=>144305}, 1960=>{:birth=>4954}, 1980=>{:birth=>131486}, 2000=>{:birth=>82277}},
 "VA"=>{:males=>62375, :females=>60118, :weight=>894804.7685623148, 1980=>{:birth=>35853}, 1960=>{:birth=>1722}, 1970=>{:birth=>23111}, 1990=>{:birth=>40375}, 2000=>{:birth=>21432}},
 "FL"=>{:males=>125129, :females=>119100, :weight=>1775657.1662042558, 2000=>{:birth=>45313}, 1960=>{:birth=>2281}, 1970=>{:birth=>43130}, 1980=>{:birth=>69383}, 1990=>{:birth=>84122}},
 "ID"=>{:males=>12883, :females=>12071, :weight=>184917.42691712882, 2000=>{:birth=>4664}, 1960=>{:birth=>287}, 1970=>{:birth=>4685}, 1980=>{:birth=>7546}, 1990=>{:birth=>7772}},
 "TN"=>{:males=>55636, :females=>52632, :weight=>782217.2597438523, 2000=>{:birth=>18303}, 1960=>{:birth=>1558}, 1970=>{:birth=>22581}, 1980=>{:birth=>31452}, 1990=>{:birth=>34374}},
 "SC"=>{:males=>37815, :females=>36149, :weight=>530165.4320114488, 2000=>{:birth=>11584}, 1960=>{:birth=>1104}, 1970=>{:birth=>16697}, 1980=>{:birth=>21794}, 1990=>{:birth=>22785}},
 "AL"=>{:males=>43115, :females=>41417, :weight=>609594.140148182, 1970=>{:birth=>18717}, 1980=>{:birth=>25538}, 1990=>{:birth=>26086}, 2000=>{:birth=>12773}, 1960=>{:birth=>1418}},
 "AR"=>{:males=>23705, :females=>22494, :weight=>335225.1843927602, 1960=>{:birth=>706}, 1970=>{:birth=>7480}, 1980=>{:birth=>15143}, 1990=>{:birth=>14893}, 2000=>{:birth=>7977}},
 "AZ"=>{:males=>40793, :females=>39292, :weight=>585809.7674283404, 1960=>{:birth=>741}, 1970=>{:birth=>8967}, 1980=>{:birth=>19502}, 1990=>{:birth=>31673}, 2000=>{:birth=>19202}},
 "CO"=>{:males=>40596, :females=>38655, :weight=>560725.6925122027, 1960=>{:birth=>868}, 1970=>{:birth=>15740}, 1980=>{:birth=>23428}, 1990=>{:birth=>24420}, 2000=>{:birth=>14795}},
 "DC"=>{:males=>11932, :females=>11496, :weight=>164636.36047794612, 1960=>{:birth=>597}, 1970=>{:birth=>4845}, 1990=>{:birth=>7831}, 1980=>{:birth=>6837}, 2000=>{:birth=>3318}},
 "DE"=>{:males=>6637, :females=>6369, :weight=>94828.90544197214, 1960=>{:birth=>220}, 1970=>{:birth=>1950}, 1980=>{:birth=>3383}, 1990=>{:birth=>4846}, 2000=>{:birth=>2607}},
 "IA"=>{:males=>30425, :females=>28598, :weight=>444038.43881009833, 1960=>{:birth=>1040}, 1970=>{:birth=>14916}, 1980=>{:birth=>18444}, 1990=>{:birth=>16379}, 2000=>{:birth=>8244}},
 "KS"=>{:males=>27609, :females=>26260, :weight=>397576.9937414877, 1960=>{:birth=>815}, 1970=>{:birth=>11865}, 1980=>{:birth=>16724}, 1990=>{:birth=>15879}, 2000=>{:birth=>8586}},
 "LA"=>{:males=>53003, :females=>51196, :weight=>744043.5576919293, 1960=>{:birth=>1619}, 1970=>{:birth=>23564}, 1980=>{:birth=>34723}, 1990=>{:birth=>29970}, 2000=>{:birth=>14323}},
 "MA"=>{:males=>58303, :females=>55002, :weight=>837997.4550298468, 1960=>{:birth=>2053}, 1970=>{:birth=>20893}, 1980=>{:birth=>35827}, 1990=>{:birth=>36798}, 2000=>{:birth=>17734}},
 "ME"=>{:males=>11858, :females=>11201, :weight=>172541.0216542184, 1960=>{:birth=>364}, 1970=>{:birth=>6184}, 1980=>{:birth=>7170}, 1990=>{:birth=>6308}, 2000=>{:birth=>3033}},
 "MS"=>{:males=>29520, :females=>28295, :weight=>411765.1777150633, 1970=>{:birth=>10723}, 1980=>{:birth=>18985}, 1990=>{:birth=>18051}, 2000=>{:birth=>9041}, 1960=>{:birth=>1015}},
 "MT"=>{:males=>8903, :females=>8603, :weight=>128923.0922269743, 1970=>{:birth=>4374}, 1980=>{:birth=>5589}, 1990=>{:birth=>4841}, 2000=>{:birth=>2432}, 1960=>{:birth=>270}},
 "ND"=>{:males=>6998, :females=>6594, :weight=>102368.91101378539, 1960=>{:birth=>252}, 1970=>{:birth=>2553}, 1980=>{:birth=>4568}, 1990=>{:birth=>4246}, 2000=>{:birth=>1973}},
 "NE"=>{:males=>18748, :females=>17750, :weight=>271215.06011395797, 1960=>{:birth=>552}, 1970=>{:birth=>8716}, 1980=>{:birth=>11222}, 1990=>{:birth=>10463}, 2000=>{:birth=>5545}},
 "NH"=>{:males=>10694, :females=>10345, :weight=>158023.75807133515, 1960=>{:birth=>251}, 1970=>{:birth=>4668}, 1980=>{:birth=>6602}, 1990=>{:birth=>6411}, 2000=>{:birth=>3107}},
 "NJ"=>{:males=>73681, :females=>70699, :weight=>1054532.6999186778, 1960=>{:birth=>2492}, 1970=>{:birth=>22987}, 1980=>{:birth=>44913}, 1990=>{:birth=>49526}, 2000=>{:birth=>24462}},
 "NM"=>{:males=>16960, :females=>16490, :weight=>236997.40123457593, 1960=>{:birth=>452}, 1970=>{:birth=>4840}, 1980=>{:birth=>10510}, 1990=>{:birth=>11615}, 2000=>{:birth=>6033}},
 "OK"=>{:males=>34530, :females=>33093, :weight=>495564.38264451333, 1960=>{:birth=>912}, 1970=>{:birth=>13948}, 1980=>{:birth=>22169}, 1990=>{:birth=>19972}, 2000=>{:birth=>10622}},
 "OR"=>{:males=>31066, :females=>29696, :weight=>456961.9939287614, 1960=>{:birth=>788}, 1970=>{:birth=>12576}, 1980=>{:birth=>18004}, 1990=>{:birth=>19372}, 2000=>{:birth=>10022}},
 "SD"=>{:males=>7769, :females=>7255, :weight=>112536.69226665903, 1960=>{:birth=>240}, 1970=>{:birth=>2501}, 1980=>{:birth=>5256}, 1990=>{:birth=>4621}, 2000=>{:birth=>2406}},
 "VT"=>{:males=>5407, :females=>5230, :weight=>78668.83203982572, 1970=>{:birth=>2727}, 1980=>{:birth=>3369}, 1990=>{:birth=>3028}, 1960=>{:birth=>161}, 2000=>{:birth=>1352}},
 "WV"=>{:males=>18009, :females=>17026, :weight=>255868.39104596787, 1960=>{:birth=>646}, 1970=>{:birth=>9018}, 1980=>{:birth=>11152}, 1990=>{:birth=>9607}, 2000=>{:birth=>4612}},
 "WY"=>{:males=>4910, :females=>4698, :weight=>69187.60774940423, 1970=>{:birth=>1698}, 1980=>{:birth=>3783}, 1990=>{:birth=>2658}, 1960=>{:birth=>134}, 2000=>{:birth=>1335}}}

Benchmark.ips do |x|
  x.config(time: 10)
  x.report('hash each_key') {
    100.times do
      array = []

      structure.each_key do |key|
        array <<  [
          key,
          structure[key].dig(1970, :birth),
          structure[key].dig(1980, :birth),
          structure[key].dig(1990, :birth),
          structure[key].dig(2000, :birth),
          structure[key][:males],
          structure[key][:females],
          structure[key][:weight] / (structure[key][:females] + structure[key][:males])
        ]
      end
    end
  }

  x.report('hash keys.each') {
    100.times do
      array = []

      structure.keys.each do |key|
        array <<  [
          key,
          structure[key].dig(1970, :birth),
          structure[key].dig(1980, :birth),
          structure[key].dig(1990, :birth),
          structure[key].dig(2000, :birth),
          structure[key][:males],
          structure[key][:females],
          structure[key][:weight] / (structure[key][:females] + structure[key][:males])
        ]
      end
    end
  }

  x.report('hash each faster') {
    100.times do
      array = []
      structure.each do |state|
        array <<  [
          state[0],
          state[1].dig(1970, :birth),
          state[1].dig(1980, :birth),
          state[1].dig(1990, :birth),
          state[1].dig(2000, :birth),
          state[1][:males],
          state[1][:females],
          state[1][:weight] / (state[1][:females] + state[1][:males])
        ]
      end
    end
  }

  x.report('hash map'){
    100.times do
      array = structure.map do |state|
        [
          state[0],
          state[1].dig(1970, :birth),
          state[1].dig(1980, :birth),
          state[1].dig(1990, :birth),
          state[1].dig(2000, :birth),
          state[1][:males],
          state[1][:females],
          state[1][:weight] / (state[1][:females] + state[1][:males])
        ]
      end
    end
  }

  x.compare!
end

Benchmark.ips do |x|
  x.config(time: 10)
  number = "1999"

  x.report('decade to_i -'){
    10000.times do |count|
      year = number.to_i
      year - (year % 10)
    end
  }

  x.report('decade to_i * faster'){
    10000.times do |count|
      number.to_i/10*10
    end
  }

  x.report('decade string'){
    10000.times do |count|
      number[3] = '0'
    end
  }

  x.compare!
end


Benchmark.ips do |x|
  x.config(time: 10)
  array = []

  10000.times do |count|
    array << "count_#{count}"
  end
  hash = {}
  x.report('hash to_sym'){
    array.each do |element|
      state = element.to_sym
      hash[state] = element
    end

    hash.keys.each do |element|
      hash[element]
    end
  }

  x.report('hash string faster'){
    array.each do |element|
      hash[element] = element
    end

    hash.keys.each do |element|
      hash[element]
    end
  }

  x.compare!
end


Benchmark.ips do |x|
  x.config(time: 10)

  x.report('hash key as string access hash') {
    x = {}
    year = '1989'
    x[year] = 1

    100.times do
      x[year]
    end
  }

  x.report('hash key as integer access hash faster') {
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
  x.config(time: 10)

  x.report('increment i += 1') {
    i = 0
    2000000.times do
      i += 1
    end
  }

  x.report('incrementi = i + 1 same-ish') {
    i = 0
    2000000.times do
      i = i + 1
    end
  }

  x.compare!
end

Benchmark.ips do |x|
  x.config(time: 10)

  x.report('increment hash key +=  1 same-ish') {
    structure = {i: 0}

    10000.times do
      structure[:i] += 1
    end
  }

  x.report('increment hash key key = key + 1') {
    structure = {i: 0}

    10000.times do
      structure[:i] = structure[:i] + 1
    end
  }

  x.compare!
end
