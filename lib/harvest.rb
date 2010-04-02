require 'happymapper'
require 'httparty'
require 'base64'
require 'builder'
require 'delegate'

require 'harvest/credentials'
require 'harvest/errors'
require 'harvest/robust_client'
require 'harvest/timezones'

require 'harvest/base'

%w(crud activatable).each {|a| require "harvest/behavior/#{a}"}
%w(base_model client contact project task person rate_limit_status).each {|a| require "harvest/#{a}"}
%w(base account clients contacts projects tasks people).each {|a| require "harvest/api/#{a}"}

module Harvest
  class << self
    def client(subdomain, username, password, options = {})
      Harvest::Base.new(subdomain, username, password, options)
    end
    
    def robust_client(subdomain, username, password, options = {})
      retries = options.delete(:retry)
      Harvest::RobustClient.new(client(subdomain, username, password, options), (retries || 5))
    end
  end
end