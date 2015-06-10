module AppleSearcher
  class InvalidSerialNumber < StandardError; end;

  class ParserError < StandardError; end;

  INVALID_IMEI_MSG  = "serial number is not valid"
  EMPTY_IMEI_MSG    = "unable to complete your request at this time"
end