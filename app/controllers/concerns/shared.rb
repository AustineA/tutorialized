module Shared
  extend ActiveSupport::Concern

  def country_by_ip
    # 129.56.85.93 niger
    # 84.17.36.91
    # 197.251.212.242 Ghana?
    # 102.140.226.63 Uganda
    # 102.165.19.19 South Africa

    local = "129.56.85.93"
    db = MaxMindDB.new('./GeoLite2-Country.mmdb')

    request_ip = request.remote_ip == "::1" ? local : request.remote_ip == "127.0.0.1" ? local : request.remote_ip
    request_data = db.lookup(request_ip)
    country = request_data.country.name
    print "Your IP is #{request_ip}, you're in #{@country}"

    return country
  end
  
end