def temp_yaml_file
  temp_yaml_file = Tempfile.new('valid_yaml.yml')
  temp_yaml_file << "base_url:      BASE_URL_YAML \n"
  temp_yaml_file << "client_id:     CLIENT_ID_YAML \n"
  temp_yaml_file << "client_secret: CLIENT_SECRET_YAML \n"
  temp_yaml_file << "app_id:        APP_ID_YAML \n"
  temp_yaml_file << "access_token:  CLIENT_ACCESS_TOKEN_YAML \n"
  temp_yaml_file << "refresh_token: REFRESH_ACCESS_TOKEN_YAML"
  temp_yaml_file.rewind
  return temp_yaml_file
end

def valid_hash_settings
  return {
    base_url:       "BASE_URL_HASH",
    client_id:      "CLIENT_ID_HASH",
    client_secret:  "CLIENT_SECRET_HASH",
    app_id:         "APP_ID_HASH",
    access_token:   "RANDOM_TOKEN_HASH",
    refresh_token:  "REFRESH_TOKEN_HASH"
  }
end

def temp_corrupt_yaml_file
  temp_corrupt_yaml_file = Tempfile.new('corrupt_yaml.yml')
  temp_corrupt_yaml_file << "[]}{{@##{Time.now}"
  temp_corrupt_yaml_file.rewind
  return temp_corrupt_yaml_file
end

def partial_yaml_file
  partial_yaml_file = Tempfile.new('partial_valid_yaml.yml')
  partial_yaml_file << "base_url::     BASE_URL_YAML \n"
  partial_yaml_file << "client_id:     CLIENT_ID_YAML \n" 
  partial_yaml_file << "client_secret: CLIENT_SECRET_YAML \n"
  partial_yaml_file << "[]}{{@##{Time.now}"
  partial_yaml_file.rewind
  return partial_yaml_file
end

def reset_settings
  MercadoPago.settings.base_url       = "https://api.mercadopago.com"
  MercadoPago.settings.client_id      = ""
  MercadoPago.settings.client_secret  = ""
  MercadoPago.settings.app_id         = ""
  MercadoPago.settings.access_token   = ""
  MercadoPago.settings.refresh_token  = ""
end

def default_settings_hash
  {
    :base_url=>"https://api.mercadopago.com",
    :client_id=>"",
    :client_secret=>"",
    :access_token=>"",
    :refresh_token=>"",
    :app_id=>""
  }
end
