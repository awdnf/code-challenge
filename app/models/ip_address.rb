class IpAddress

  @@ips_lock = Mutex.new
  @@ips = {}

  def self.store(ip_list)

    @@ips_lock.synchronize do
      ip_list.each do |ip_with_numbers|
        ip, number_list = ip_with_numbers.split(':')

          @@ips[ip] = SortedSet.new unless @@ips.has_key?(ip)

          if number_list
            number_list = number_list.scan(/\d+/i).map(&:to_i)

            @@ips[ip].merge(number_list)
          end
        end
    end
    @@ips
  end

  def self.compute
    ips = {}
    @@ips_lock.synchronize do
      ips = @@ips.clone
      @@ips.clear
    end
    ips
  end

end
