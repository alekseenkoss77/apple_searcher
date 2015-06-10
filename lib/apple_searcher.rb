require "apple_searcher/version"
require "apple_searcher/errors"
require "apple_searcher/parser"
require "apple_searcher/devise"

module AppleSearcher
  class Configuration
    attr_accessor :url, :method, :path, :agent

    def initialize
      @url = "https://selfsolve.apple.com"
      @path = "/wcResults.do"
      @method = "post"
      @agent = "Mozilla/5.0 (Windows NT 6.3; rv:36.0) Gecko/20100101 Firefox/36.0"
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration || Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end
end
