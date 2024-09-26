namespace :benchmark do
  def request(serializer_name, count)
    uri = URI.parse("http://localhost:3000/api/v1/users?serializer=#{serializer_name}&count=#{count}")
    Net::HTTP.get(uri)
  end

  def benchmark(serializer_name, count: 100, ignore_detail_time: false)
    execute_count = 20
    total_time = 0
    padding = 12

    execute_count.times do |i|
      time = Benchmark.measure do
        request(serializer_name, count)
      end
      total_time += time.real
      print "#{serializer_name.ljust(padding)} #{i+1}: #{time.real * 1000} ms\n" unless ignore_detail_time
    end

    ave = total_time / execute_count
    print "\e[33m#{serializer_name.ljust(padding)} Count: #{count.to_s.ljust(4)} Average: #{(ave * 1000).floor(3)} ms\e[0m\n"
  end

  task :all do
    [ 100, 500, 1000 ].each do |count|
      print "\e[33m[#{count} records]\e[0m\n"
      %W[default blueprinter alba jbuilder jb].each do |serializer_name|
        benchmark(serializer_name, count: count, ignore_detail_time: true)
      end
      print "\n"
    end
  end

  task :blueprinter do
    benchmark('blueprinter')
  end

  task :alba do
    benchmark('alba')
  end
end
