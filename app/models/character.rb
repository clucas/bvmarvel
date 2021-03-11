class Character < ApplicationRecord
  has_many :rosters, dependent: :delete_all
  has_many :stories, through: :rosters

  def self.search(search)
    if search
      characters = Character.where("name ILIKE ?", "%#{search}%")
      if characters.empty?
        character_data = Marvel::Service.instance.characters({name: 'Spectrum'})
        stories_data = Marvel::Service.instance.character_stories(character_data)
        Marvel::Service.instance.stories_characters(stories_data)
      end
    end
    Character.all.order(:id)
  end

  def self.api(options = {})
    Marvel::Service
  end

  def self.reset_for_new_search
    Roster.delete_all
    Character.delete_all
    Story.delete_all
  end
end
