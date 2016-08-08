require 'yaml'
require 'logger'

module MercadoPago



  class Settings
    attr_accessor :base_url
    attr_accessor :client_id,     :client_secret
    attr_accessor :access_token,  :refresh_token
    attr_accessor :app_id

    include RESTClient

    def initialize
      @base_url = "https://api.mercadopago.com" # Set the default base_url
    end

    def try_to_complete_credentials

      if @client_id.to_s != "" && @client_secret.to_s != ""
        data  = {
          grant_type:    'client_credentials',
          client_id:     @client_id,
          client_secret: @client_secret
        }
        response = request(method: 'post', path: '/oauth/token', json_post_params: data.to_json)
        if response.code.to_i == 200
          @access_token = response.body["access_token"]
        else
          warn("AN ERROR: #{response.body.message}")
        end
      end
    end

    def to_hash
      return {
        base_url:     @base_url,
        client_id:    @client_id,     client_secret: @client_secret,
        access_token: @access_token,  refresh_token: @refresh_token,
        app_id:       @app_id
      }
    end

    def client_id=(value)
      @client_id = value
      try_to_complete_credentials
    end

    def client_secret=(value)
      @client_secret = value
      try_to_complete_credentials
    end


    def config_with(yaml: "", hash: {})
      load_from_yaml(yaml) if yaml != ""
      load_from_hash(hash) if hash != {}
    end

    private

    def load_from_yaml(yaml)
      begin
        load_from_hash(yaml.class == String ? YAML.load_file(yaml) : YAML::load(yaml.read))
      rescue Errno::ENOENT
        warn "YAML configuration file couldn't be found. Using defaults."
      rescue Psych::SyntaxError
        warn "YAML configuration file contains invalid syntax. Using defaults."
      end
    end

    def load_from_hash(hash)
      hash.map{|key, value| instance_variable_set("@#{key.to_s}", value)}
    end

  end

  class << self
    attr_writer :settings
  end

  def self.settings
    @settings ||= Settings.new
  end

  def self.config
    yield self.settings
  end

end
