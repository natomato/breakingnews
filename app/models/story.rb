require 'open-uri'
# require 'addressable/uri'

class Story < ActiveRecord::Base
  # scope :latest ->
  validates :website, uniqueness: true

  def self.update
    url = 'http://www.cnn.com'
    headlines = get_headlines(url) 
    # latest = (headlines)
    headlines.each do |link|
      website = create_website(link["href"])
      headline = link.text
      paragraph = get_lead_paragraph(website)
      s = Story.new(website: website, headline: headline, lead_paragraph: paragraph)
      s.save
    end
    Story.all
  end

  # def self.get_website(link)
  #   url = Addressable::URI.new(
  #     :scheme => "http",
  #     :host => "maps.googleapis.com",
  #     :path => "/maps/api/geocode/json",
  #     :query_values => {
  #       :address => address,
  #       :sensor => "false"
  #     }).to_s
  # end

  def self.create_website(href)
    if href[0..3] == "http"
      href
    else
      'http://www.cnn.com' + href
    end
  end

  def self.get_headlines(url)
    doc = Nokogiri::HTML(open(url))
    doc.css('#cnn_maintt2bul .cnnPreWOOL+ a')
  end

  # TODO later 
  def self.remove_duplicates(headlines)

  end

  def self.get_lead_paragraph(link)
    doc = Nokogiri::HTML(open(link))
    doc.xpath('//p[1]').children.text
  end

  def self.latest
    Story.order('created_at DESC').limit(5)
    # where("created_at >= ?", Time.zone.now.beginning_of_day).limit(5)
  end

  private

  def one_day_apart?(other)
    (self.created_at.to_date - other.created_at.to_date).abs == 1
  end
end
