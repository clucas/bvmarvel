gem 'marvelite'

require 'yaml'
require 'marvelite'

CONFIG = YAML.load_file(File.join('config', 'marvel_api.yml')) ['development'].transform_keys(&:to_sym)
pp CONFIG
client = Marvelite::API::Client.new(CONFIG[:api_keys].transform_keys(&:to_sym))
pp client.characters(:name => 'Spectrum')
p "======================================================================================================="

# "path"
# "/v1/public/characters"
# "params"
# {:name=>"Spectrum",
#  :apikey=>"a0ca49677e748ef8d112b5e9ff0ea970",
#  :ts=>1615408916,
#  :hash=>"00ca08e2817385b12186fbdf08d8e517"}
# "headers"
# {"Accept-Encoding"=>"gzip"}


## CHARACTERS by name
response_data = File.open('spectrum.json', 'r') { |f| File.read(f) }

result = JSON.parse(response_data)['data']['results'].first
pp result

# name, id, description, and picture of Spectrum
c = { name: result['name'],
  marvel_uuid: result['id'],
  description: result['description'],
  picture_url: "#{result['thumbnail']['path']}.#{result['thumbnail']['extension']}"
}

pp c

## STORIES FOR A CHARACTER
response_data = File.open('stories.json', 'r') { |f| File.read(f) }

results = JSON.parse(response_data)['data']['results']

stories_to_fetch = []
results.each do |story|
  s = { title: story['title'],
    marvel_uuid: story['id'],
    characters_available: story['characters']['available'],
    characters_returned: story['characters']['returned']
  }
  stories_to_fectch << s unless s[:characters_available] == s[:characters_returned]
  pp s
end
pp stories_to_fetch

## GET CHARACTER FOR STORY