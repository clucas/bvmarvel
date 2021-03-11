module Marvel
  CONFIG = YAML.load_file(
      File.join(Rails.root, 'config', 'marvel_api.yml')) [Rails.env].deep_symbolize_keys
end