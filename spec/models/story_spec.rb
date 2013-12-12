require 'spec_helper'

describe Story do
  

  describe 'fetch_headlines' do
    let(:path) { File.join(File.dirname(__FILE__), 'CNN_Snapshot.html')}
    let(:doc) { File.open( path, 'r')}
    let(:website) { Nokogiri::HTML(open(doc)) }

    it 'grabs the first headline' do
      headline = website.css('#cnn_maintt2bul .cnnPreWOOL+ a')[0]
      expect(headline.text).to eq("NASA: Space station pump fails")
    end

  end

  describe 'update' do

    it 'creates a story object with a headline' do
      pending "file loading test"
      Story.update
      story = Story.last
      expect(story.created_at).not_to be_blank
    end

    it 'only updates at most 10 stories at a time' do
      pending "file loading test"
      last_count = Story.count
      Story.update
      expect(Story.count).to be < (last_count + 11)
    end
    
    it 'will not save duplicate stories' do
      pending "file loading test"
      story = Story.new(website: "http://story1")
      copy  = Story.new(website: "http://story1")
      story.save
      expect(copy).not_to be_valid
    end
  end
end
