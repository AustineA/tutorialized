module Shared
  extend ActiveSupport::Concern

  def country_by_ip
    local = "102.165.19.19"
    db = MaxMindDB.new('./GeoLite2-Country.mmdb')

    request_ip = request.remote_ip == "::1" ? local : request.remote_ip == "127.0.0.1" ? local : request.remote_ip
    request_data = db.lookup(request_ip)
    country = request_data.country.name
    print "Your IP is #{request_ip}, you're in #{@country}"

    return country
  end
  
end