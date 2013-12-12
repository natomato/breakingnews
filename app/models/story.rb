require 'open-uri'

class Story < ActiveRecord::Base
  validates :website, uniqueness: true 

  def self.latest(n)
    Story.update
    Story.order('position DESC').limit(n)
  end

  def self.update
    url = 'http://www.cnn.com'
    headlines = latest_headlines(url)

    stories = []
    headlines.each_with_index do |link, index|
      s = Story.new()
      s.website = extract_website(link["href"])
      s.host = URI.parse(s.website).host
      s.headline = link.text
      s.position = set_position(index)
      stories << s
    end

    stories.map do |s|
      if s.valid?
        s.lead_paragraph = s.get_lead_paragraph(s.website)
        s.save
      end
    end
  end

  def self.latest_headlines(url)
    doc = Nokogiri::HTML(open(url))
    doc.css('#cnn_maintt2bul .cnnPreWOOL+ a')[0...5]
  end

  def self.extract_website(href)
    if href[0..5] =~ /http/
      website = href.strip
    else
      website = 'http://www.cnn.com' + href
    end
  end

  def get_lead_paragraph(link)
    doc = Nokogiri::HTML(open(link))
    candidates = []

    matchers = [ 'p',
                 '#article-body p',
                 '#slide-content p',
               ]
   
    matchers.each do |matcher, url_parts|
      next if doc.css(matcher).empty?
      paragraph = doc.css(matcher)[0].text

      if link.split('/')[3] == "video"
        paragraph.concat( " Follow link to watch the full video." )
      end

      candidates << paragraph
    end

    pick_best_paragraph(candidates)

  end

  def self.set_position(index)
    date = Time.now
    index = 999 - index #the first item must have the largest number
    timestamp = date.strftime('%Y%m%d%H%M') + index.to_s.rjust(3, "0")
  end

  private #--------------------------------------------------------------------

  def pick_best_paragraph(candidates)
    
    error_message = "Sorry, there was a problem fetching this story. Please follow the link for the full story"
    
    paragraph = candidates.find { |p| p.size > 70 } || error_message
    
    # when story too long, stop at the last sentence before 500 charsacters
    if paragraph.size > 500
      paragraph = paragraph[0..500]
      last_period = paragraph.rindex(/\./)
      paragraph[0..last_period]
    end 

    paragraph
  end


end
