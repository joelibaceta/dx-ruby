require_relative 'spec_helper'

describe "Initial Settings Setup" do

  context "Setting valid parameters" do

    after(:each) { reset_settings }

    it "Should return the hardcoded base url" do
      expect(MercadoPago.settings.base_url).to eql("https://api.mercadopago.com")
    end

    it "From a Yaml File" do
      MercadoPago.settings.config_with yaml: temp_yaml_file

      expect(MercadoPago.settings.base_url).to      eql("BASE_URL_YAML")
      expect(MercadoPago.settings.client_id).to     eql("CLIENT_ID_YAML")
      expect(MercadoPago.settings.client_secret).to eql("CLIENT_SECRET_YAML")
      expect(MercadoPago.settings.app_id).to        eql("APP_ID_YAML")
      expect(MercadoPago.settings.access_token).to  eql("CLIENT_ACCESS_TOKEN_YAML")
      expect(MercadoPago.settings.refresh_token).to eql("REFRESH_ACCESS_TOKEN_YAML")
    end

    it "From String from the Yaml file path" do
      MercadoPago.settings.config_with yaml: temp_yaml_file.path

      expect(MercadoPago.settings.base_url).to      eql("BASE_URL_YAML")
      expect(MercadoPago.settings.client_id).to     eql("CLIENT_ID_YAML")
      expect(MercadoPago.settings.client_secret).to eql("CLIENT_SECRET_YAML")
      expect(MercadoPago.settings.app_id).to        eql("APP_ID_YAML")
      expect(MercadoPago.settings.access_token).to  eql("CLIENT_ACCESS_TOKEN_YAML")
      expect(MercadoPago.settings.refresh_token).to eql("REFRESH_ACCESS_TOKEN_YAML")
    end

    it "From a Hash" do
      MercadoPago.settings.config_with hash: valid_hash_settings

      expect(MercadoPago.settings.base_url).to      eql("BASE_URL_HASH")
      expect(MercadoPago.settings.client_id).to     eql("CLIENT_ID_HASH")
      expect(MercadoPago.settings.client_secret).to eql("CLIENT_SECRET_HASH")
      expect(MercadoPago.settings.app_id).to        eql("APP_ID_HASH")
      expect(MercadoPago.settings.access_token).to  eql("RANDOM_TOKEN_HASH")
      expect(MercadoPago.settings.refresh_token).to eql("REFRESH_TOKEN_HASH")
    end

    it "One by one" do
      MercadoPago.settings.base_url       = "INDIVIDUAL_URL"
      MercadoPago.settings.client_id      = "INDIVIDUAL_CLIENT_ID"
      MercadoPago.settings.client_secret  = "INDIVIDUAL_CLIENT_SECRET"
      MercadoPago.settings.app_id         = "INDIVIDUAL_APP_ID"
      MercadoPago.settings.access_token   = "INDIVIDUAL_ACCESS_TOKEN"
      MercadoPago.settings.refresh_token  = "INDIVIDUAL_REFRESH_TOKEN"

      expect(MercadoPago.settings.base_url).to      eql("INDIVIDUAL_URL")
      expect(MercadoPago.settings.client_id).to     eql("INDIVIDUAL_CLIENT_ID")
      expect(MercadoPago.settings.client_secret).to eql("INDIVIDUAL_CLIENT_SECRET")
      expect(MercadoPago.settings.app_id).to        eql("INDIVIDUAL_APP_ID")
      expect(MercadoPago.settings.access_token).to  eql("INDIVIDUAL_ACCESS_TOKEN")
      expect(MercadoPago.settings.refresh_token).to eql("INDIVIDUAL_REFRESH_TOKEN")
    end

    it "From a Code Block" do

      MercadoPago.config do |config|
        config.base_url       = "BASE_URL_BLOCK"
        config.client_id      = "CLIENT_ID_BLOCK"
        config.client_secret  = "CLIENT_SECRET_BLOCK"
        config.app_id         = "APP_ID_BLOCK"
        config.access_token   = "ACCESS_TOKEN_BLOCK"
        config.refresh_token  = "REFRESH_TOKEN_BLOCK"
      end

      expect(MercadoPago.settings.base_url).to      eql("BASE_URL_BLOCK")
      expect(MercadoPago.settings.client_id).to     eql("CLIENT_ID_BLOCK")
      expect(MercadoPago.settings.client_secret).to eql("CLIENT_SECRET_BLOCK")
      expect(MercadoPago.settings.app_id).to        eql("APP_ID_BLOCK")
      expect(MercadoPago.settings.access_token).to  eql("ACCESS_TOKEN_BLOCK")
      expect(MercadoPago.settings.refresh_token).to eql("REFRESH_TOKEN_BLOCK")
    end

  end

  context "Setting wrong values" do

    after(:each) { reset_settings }

    it "From a Malformed Hash" do
      MercadoPago.settings.config_with hash: {key: "Random_text"}
    end

    it "From a wrong kind of input" do
      an_array  = [1, 3, 8, 2]
      an_string = "Random"
      MercadoPago.settings.config_with hash: {key: an_string}

    end

    it "From a Corrupt Yaml file" do
      MercadoPago.settings.config_with yaml: temp_corrupt_yaml_file
      expect(MercadoPago.settings.to_hash).to eql(default_settings_hash)
    end

    it "From a Partial valid Yaml file" do
      MercadoPago.settings.config_with yaml: partial_yaml_file
      expect(MercadoPago.settings.to_hash).to eql(default_settings_hash)
    end

    it "From an non-existing Yaml file" do
      MercadoPago.settings.config_with yaml: "/random/path.yml"
      expect(MercadoPago.settings.to_hash).to eql(default_settings_hash)
    end

  end

  context "Guessing the missing credentials" do

    after(:each) { reset_settings }

    it "In a basic setup" do
      MercadoPago.settings.client_id     = "CLIENT_ID"
      MercadoPago.settings.client_secret = "CLIENT_SECRET"
      expect(MercadoPago.settings.access_token).to eql("ACCESS_TOKEN_GUESSED")
    end
  end

  context "Getting information about the settings" do
    after(:each) { reset_settings }
    it "Get a hash with the setting params" do
      expect(MercadoPago.settings.to_hash).to eql(default_settings_hash)
    end
  end

end
