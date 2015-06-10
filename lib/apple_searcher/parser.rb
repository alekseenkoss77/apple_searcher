module AppleSearcher
  class Parser
    attr_reader :document

    attr_accessor :warranty, :expired_date, :errors

    def initialize(html)
      @errors = []
      @document = html
    end

    def parse
      validate!
      hardware_warranty_info
      self
    end

    def valid?
      errors.size == 0
    end

    private

    def validate!
      check_invalid_message
      check_presence_imei
    end

    def hardware_warranty_info
      return false unless valid?
      # firstly check active warranty
      # find JavaScript code string with Hardware Warranty info      
      hw_rg = document.match(/warrantycheck\.displayHWSupportInfo\((.*)\)/)
      # next - find true or false (the first argument)
      status = hw_rg[1].split(',')[0]
      expired_info = hw_rg[1].match(/Date:\s*(.*)<br\/>/)
      @expired_date = expired_info[1] unless expired_info.nil?

      return false if status.nil?

      if status == 'true'
        @warranty = true
        @status = 'In Warranty'
      elsif status == 'false'
        @warranty = false 
        @status = 'Out of Warranty'
      end
      self
    end

    def check_invalid_message
      msg = document.match(/#{AppleSearcher::INVALID_IMEI_MSG}/)
      @errors << { imei: 'SN is invalid. Check yout imei and try again!' } unless msg.nil?
    end

    def check_presence_imei
      msg = document.match(/#{AppleSearcher::EMPTY_IMEI_MSG}/)
      @errors << { imei: 'SN is empty. Check yout imei and try again!' } unless msg.nil?
    end
  end
end