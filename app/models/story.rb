require 'open-uri'

class Story < ActiveRecord::Base
  validates :website, uniqueness: true 

  def self.update
    url = 'http://www.cnn.com'
    headlines = latest_headlines(url) #[0...10]

    stories = []
    headlines.each do |link|
      s = Story.new()
      s.website = extract_website(link["href"])
      s.host = URI.parse(s.website).host
      s.headline = link.text
      stories << s
    end

    stories.map do |s|
      if s.valid?
        s.lead_paragraph = s.get_lead_paragraph(s.website)
        s.save
      end
    end
  end

  def self.extract_website(href)
    if href[0..3] == "http"
      href
    else
      'http://www.cnn.com' + href
    end
  end

  def self.latest_headlines(url)
    doc = Nokogiri::HTML(open(url))
    doc.css('#cnn_maintt2bul .cnnPreWOOL+ a')
  end

  def get_lead_paragraph(link)
    doc = Nokogiri::HTML(open(link))
    host = URI.parse(link).host
    url_parts = link.split('/')

    if url_parts[3] == 'video'
      candidate = doc.xpath("//meta[@name='description']/@content").text
      candidate += "Follow link to watch the full video"
      supplement = ""
    end
    if url_parts[2] == 'eatocracy.cnn.com'
      candidate  = doc.css('p')[0].text 
      supplement = doc.css('p')[1].text
    end
    if url_parts[2] == 'politicalticker.blogs.cnn.com'
      candidate  = doc.css('p')[0].text 
      supplement = doc.css('p')[1].text
    end
    if url_parts[2] == 'www.hlntv.com'
      candidate  = doc.css('p')[0].text 
      supplement = doc.css('p')[1].text
    end
    if url_parts[2] == 'bleacherreport.com'
      candidate  = doc.css('#article-body p')[0].text
      supplement = doc.css('#article-body p')[1].text
    end
    if url_parts[2] == 'reliablesources.blogs.cnn.com'
      candidate  = doc.css('p')[0].text 
      supplement = doc.css('p')[1].text
    end
    if candidate.nil?
      candidate  = doc.css('p')[0].text 
      supplement = doc.css('p')[1].text
    end

    if candidate.length < 50
      candidate = "#{candidate} \n #{supplement}"
      logger.debug "...............candidate: #{candidate}"
      logger.debug "\n ..............supplement: #{supplement}"
    end

    candidate
  end

  def self.latest(n)
    Story.update
    Story.order('created_at ASC').limit(n)
  end
end
