namespace :benchmark do
  def request(serializer_name, count)
    uri = URI.parse("http://localhost:3000/api/v1/users?serializer=#{serializer_name}&count=#{count}")
    Net::HTTP.get(uri)
  end

  def benchmark(serializer_name, count: 100, ignore_detail_time: false)
    execute_count = 200
    total_time = 0
    execute_count.times do |i|
      time = Benchmark.measure do
        request(serializer_name, count)
      end
      total_time += time.real
      print "[#{serializer_name}] #{i+1}: #{time.real * 1000} ms\n" unless ignore_detail_time
    end

    ave = total_time / execute_count
    print "\e[33m[#{serializer_name}] Count: #{count} Average: #{(ave * 1000).floor(3)} ms\e[0m]\n"
  end

  task :all do
    benchmark("blueprinter", count: 100, ignore_detail_time: true)
    benchmark("blueprinter", count: 500, ignore_detail_time: true)
    benchmark("blueprinter", count: 1000, ignore_detail_time: true)
    benchmark("alba", count: 100, ignore_detail_time: true)
    benchmark("alba", count: 500, ignore_detail_time: true)
    benchmark("alba", count: 1000, ignore_detail_time: true)
  end

  task :blueprinter do
    benchmark("blueprinter")
  end

  task :alba do
    benchmark("alba")
  end
end
