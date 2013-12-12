require 'nokogiri'
require 'open-uri'
require 'pry'
require 'pry-debugger'

News_Story = Struct.new(:website, :headline, :paragraph)
stories = {}

url = 'http://www.cnn.com'
doc = Nokogiri::HTML(open(url))
news = doc.css('#cnn_maintt2bul .cnnPreWOOL+ a')

# doc.xpath('//li[starts-with(@class, "c_hpbullet")]').each do |el|
#   p [el.attributes['class'].value, el.children[0].text]
# end

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
      paragraph.concat( " Follow link to watch the full video" )
    end

    candidates << paragraph
    puts "Candidate: #{paragraph.size} Matcher: #{matcher}"
  end

  pick_best_paragraph(candidates)

end

def pick_best_paragraph(candidates)
  paragraph = candidates.find { |p| p.size > 70 }
  
  paragraph ||= "Sorry, there was a problem fetching this story. Please follow the link for the full story"
  
  if paragraph.size > 500
    paragraph = paragraph[0..500]
    last_period = paragraph.rindex(/\./)
    paragraph[0..last_period]
  end 

  paragraph
end

news.each_with_index do |link, index|
  puts "Current Iteration #{index}"

  href = link["href"]
  if href[0..5] =~ /http/
    website = href.strip
  else
    website = 'http://www.cnn.com' + href
  end
  puts "Source: " + website

  paragraph = get_lead_paragraph(website)
  puts "Paragraph: " + paragraph.length.to_s 
  binding.pry
  stories[index] = News_Story.new(website, link.text, paragraph)
end

