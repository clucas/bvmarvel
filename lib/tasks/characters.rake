namespace :marvel do
  task populate: :environment do
    response_data = File.open('spectrum.json', 'r') { |f| File.read(f) }

    result = JSON.parse(response_data)['data']['results'].first
    pp result

# name, id, description, and picture of Spectrum
    c = { name: result['name'],
          marvel_uuid: result['id'],
          description: result['description'],
          picture_url: "#{result['thumbnail']['path']}.#{result['thumbnail']['extension']}"
    }
    character = Character.create_or_find_by(c)

## STORIES FOR A CHARACTER
    response_data = File.open('stories.json', 'r') { |f| File.read(f) }

    results = JSON.parse(response_data)['data']['results']

    stories_to_fetch = []
    results.each do |story|
      s = { title: story['title'],
            marvel_uuid: story['id']
      }
      characters_available = story['characters']['available']
      characters_returned = story['characters']['returned']
      story = Story.find_or_create_by(s)
      character.stories << story
      stories_to_fectch << s unless characters_available  == characters_returned
      pp s
    end
    pp stories_to_fetch

  end
end