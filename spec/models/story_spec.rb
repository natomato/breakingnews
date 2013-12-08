require 'spec_helper'

describe Story do
  
  describe 'update' do

    it 'creates a story object with a headline' do
      Story.update
      story = Story.last
      expect(story.created_at).not_to be_blank
    end

    it 'only updates at most 10 stories at a time' do
      last_count = Story.count
      Story.update
      expect(Story.count).to be < (last_count + 11)
    end
    
    it 'will not save duplicate stories' do
      story = Story.new(website: "http://story1")
      copy  = Story.new(website: "http://story1")
      story.save
      expect(copy).not_to be_valid
    end
  end
end
