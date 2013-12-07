require 'spec_helper'

describe Story do
  
  describe 'update' do

    it 'creates a story object with a headline' do
      Story.update
      story = Story.last
      expect(story.created_at).not_to be_blank
    end

    it 'will not save duplicate stories' do
      story = new Story(website: "http://story1")
      copy  = new Story(website: "http://story1")
      story.save
      expect(copy.save).not_to be_valid
    end
  end
end
