class Marvel::Service
  include Singleton

  def characters(options = {})
    if options[:name]
      characters_data = {}
      path = Marvel::CONFIG[:config][:characters_path]
      query_options = { name: options[:name] }
      response = api_client.get(path, query_options)
      results = response.body[:data][:results]
      results.each do |result|
        character_params = parse_character(result)
        log("character found: #{character_params}")
        character = Character.create_or_find_by(character_params)
        log("creating character: #{character}")
        characters_data[character_params[:name]] = {}
        characters_data[character_params[:name]][:marvel_uuid] = character.marvel_uuid
        characters_data[character_params[:name]][:stories_number] = result[:stories][:available]
      end
      characters_data
      # https://gateway.marvel.com:443/v1/public/characters?name=spectrum&apikey=a0ca49677e748ef8d112b5e9ff0ea970
    else
      { '0': { marvel_uuid: nil, stories_number: 0 } }
    end
  end

  def character_stories(character_data)
    stories = []
    character_data.keys.each do |character_info|
      character = Character.find_by(marvel_uuid: character_data[character_info][:marvel_uuid])
      path = Marvel::CONFIG[:config][:character_stories_path].gsub(":id", character_data[character_info][:marvel_uuid])
      query_options = { limit: character_data[character_info][:stories_number] }
      response = api_client.get(path, query_options)
      results = response.body[:data][:results]
      results.each do |story_info|
        story_options = { title: story_info[:title], marvel_uuid: story_info[:id] }
        log("story found: #{story_options}")
        story = Story.find_or_create_by(story_options)
        log("creating story: #{story}")
        if Roster.find_by(character_id: character.id, story_id: story.id).nil?
          character.stories << story
        end
        stories << story_options.merge({ characters_number: story_info[:characters][:available]})
      end
    end
    stories
  end

  def stories_characters(stories_data)
    characters = []
    log "number of stories: #{stories_data.count}"
    stories_data.each do |story_info|
      story = Story.find_by(marvel_uuid: story_info[:marvel_uuid])
      log('story found #{story.title}')
      path = Marvel::CONFIG[:config][:stories_characters_path].gsub(":story_id", story_info[:marvel_uuid].to_s)
      query_options = { limit: story_info[:characters_number] }
      response = api_client.get(path, query_options)
      results = response.body[:data][:results]
      results.each do |result|
        character_params = parse_character(result)
        character = Character.create_or_find_by(character_params)
        log("character found: #{character.name}")
        if Roster.find_by(character_id: character.id, story_id: story.id).nil?
          Roster.create!(character_id: character.id, story_id: story.id)
          log("associate story #{story.id} with character: #{character.name}")
          # story.characters << character
        end
        characters << character_params.merge({ marvel_story_uuid: story.marvel_uuid })
      end
    end
    characters
  end

  private

  def api_client
    if @api_client.nil?
      @api_client = Marvel::Client.new(
          {
              public_key: Rails.application.credentials.api_keys[:public_key],
              private_key: Rails.application.credentials.api_keys[:private_key]
          }
      )
    end
    @api_client
  end

  def parse_character(result)
    {
        name: result[:name],
        marvel_uuid: result[:id],
        description: result[:description],
        picture_url: "#{result[:thumbnail][:path]}.#{result[:thumbnail][:extension]}"
    }
  end

  def log(message)
    Rails.logger.info message
  end
end