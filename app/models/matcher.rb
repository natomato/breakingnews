class Matcher
  include ActiveModel::Validations

  def initialize()

  end

  def persisted?
    false
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

end