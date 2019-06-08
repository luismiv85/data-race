class DataService
  URLS = [
    'gs://securitas/natalidad000000000000.csv',
    'gs://securitas/natalidad000000000001.csv',
    'gs://securitas/natalidad000000000002.csv',
    'gs://securitas/natalidad000000000003.csv',
    'gs://securitas/natalidad000000000004.csv',
    'gs://securitas/natalidad000000000005.csv',
    'gs://securitas/natalidad000000000006.csv',
    'gs://securitas/natalidad000000000007.csv',
    'gs://securitas/natalidad000000000008.csv',
    'gs://securitas/natalidad000000000009.csv',
    'gs://securitas/natalidad000000000010.csv',
    'gs://securitas/natalidad000000000011.csv',
    'gs://securitas/natalidad000000000012.csv',
    'gs://securitas/natalidad000000000013.csv',
    'gs://securitas/natalidad000000000014.csv',
    'gs://securitas/natalidad000000000015.csv',
    'gs://securitas/natalidad000000000016.csv',
    'gs://securitas/natalidad000000000017.csv',
    'gs://securitas/natalidad000000000018.csv',
    'gs://securitas/natalidad000000000019.csv',
    'gs://securitas/natalidad000000000020.csv',
    'gs://securitas/natalidad000000000021.csv',
    'gs://securitas/natalidad000000000022.csv',
    'gs://securitas/natalidad000000000023.csv',
    'gs://securitas/natalidad000000000024.csv',
    'gs://securitas/natalidad000000000025.csv',
    'gs://securitas/natalidad000000000026.csv',
    'gs://securitas/natalidad000000000027.csv',
    'gs://securitas/natalidad000000000028.csv',
    'gs://securitas/natalidad000000000029.csv',
    'gs://securitas/natalidad000000000030.csv',
    'gs://securitas/natalidad000000000031.csv',
    'gs://securitas/natalidad000000000032.csv',
    'gs://securitas/natalidad000000000033.csv',
    'gs://securitas/natalidad000000000034.csv',
    'gs://securitas/natalidad000000000035.csv',
    'gs://securitas/natalidad000000000036.csv',
    'gs://securitas/natalidad000000000037.csv',
    'gs://securitas/natalidad000000000038.csv',
    'gs://securitas/natalidad000000000039.csv',
    'gs://securitas/natalidad000000000040.csv',
    'gs://securitas/natalidad000000000041.csv',
    'gs://securitas/natalidad000000000042.csv',
    'gs://securitas/natalidad000000000043.csv',
    'gs://securitas/natalidad000000000044.csv',
    'gs://securitas/natalidad000000000045.csv',
    'gs://securitas/natalidad000000000046.csv',
    'gs://securitas/natalidad000000000047.csv',
    'gs://securitas/natalidad000000000048.csv',
    'gs://securitas/natalidad000000000049.csv',
    'gs://securitas/natalidad000000000050.csv',
    'gs://securitas/natalidad000000000051.csv',
    'gs://securitas/natalidad000000000052.csv',
    'gs://securitas/natalidad000000000053.csv',
    'gs://securitas/natalidad000000000054.csv',
    'gs://securitas/natalidad000000000055.csv',
    'gs://securitas/natalidad000000000056.csv',
    'gs://securitas/natalidad000000000057.csv',
    'gs://securitas/natalidad000000000058.csv',
    'gs://securitas/natalidad000000000059.csv',
    'gs://securitas/natalidad000000000060.csv',
    'gs://securitas/natalidad000000000061.csv',
    'gs://securitas/natalidad000000000062.csv',
    'gs://securitas/natalidad000000000063.csv',
    'gs://securitas/natalidad000000000064.csv',
    'gs://securitas/natalidad000000000065.csv',
    'gs://securitas/natalidad000000000066.csv',
    'gs://securitas/natalidad000000000067.csv',
    'gs://securitas/natalidad000000000068.csv'
  ]

  def initialize(file_name = nil)
    @file_names = [file_name] || URLS
    @path_download = './datas/'
  end

  def download_files
    @file_names.each do |file|
      system("gsutil -m cp -r #{file} #{@path_download}")
    end
  end
end