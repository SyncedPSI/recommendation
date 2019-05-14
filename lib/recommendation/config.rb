module Recommendation

  class << self

    attr_accessor :config

    def configure
      yield self.config ||= Config.new
    end

    def redis
      raise NoConfigureError, 'redis not configured! - Recommendation.configure { |config| config.redis = Redis.new } ' if config&.redis.nil?
      @redis ||= config.redis 
    end

    def key_expired
      config.key_expired rescue 100
    end

    def rest_client_options
      if config.nil?
        return {timeout: 5, open_timeout: 5, verify_ssl: true}
      end
      config.rest_client_options
    end
  end

  class Config
    attr_accessor :redis, :rest_client_options, :key_expired
  end

  class NoConfigureError < StandardError
  end
end