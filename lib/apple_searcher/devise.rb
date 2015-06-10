require 'faraday'
require 'faraday-cookie_jar'

module AppleSearcher
  class Devise
    attr_reader :imei, :connect

    def initialize(imei)
      @imei = imei
      @connect = Faraday.new(url: AppleSearcher.configuration.url) do |c|
        c.headers['User-Agent'] = AppleSearcher.configuration.agent
        c.use :cookie_jar
        c.adapter Faraday.default_adapter
      end
    end

    def self.find(sn)
      devise = new(sn)
      parser = devise.find_by_imei
      return nil unless parser.valid?
      parser
    end

    def self.find!(sn)
      parser = find(sn)

      raise AppleSearcher::InvalidSerialNumber,
            parser.errors[:imei] unless parser.valid?
      
      parser
    end

    def find_by_imei
      num = SecureRandom.random_number(5000)
      res = connect.post(AppleSearcher.configuration.path, "sn=#{imei}&num=#{num}")
      AppleSearcher::Parser.new(res.body).parse
    end
  end
end