require 'net/http'

class MasSearcher
  attr_reader :query

  DOMAIN_NAME = "https://www.moneyadviceservice.org.uk".freeze
  ANSWER_CSS_CLASS = ".search-results__item".freeze
  LANGUAGES = ["cy", "en"].freeze

  def initialize query
    @query = query
  end

  def call
    LANGUAGES.map(&method(:parse_answer)).reject(&:blank?)
  end

  private

  def parse_answer language
    answer = get_answer(language) or return {}

    url = answer.css("a").attr("href").value
    text = answer.css("a").inner_text
    {
      url: "#{DOMAIN_NAME}#{url}",
      text: text.strip,
      language: language
    }
  end

  def get_answer language
    uri = URI("#{DOMAIN_NAME}/#{language}/search?query=#{URI.encode(query)}")
    response = Net::HTTP.get_response uri
    body = Nokogiri::HTML(response.body)
    # Find the first <li> block that has a link tag to the current language of the website
    body.css(ANSWER_CSS_CLASS).detect do |html_block|
      html_block.css("a").attr("href").value.starts_with?("/#{language}")
    end
  end
end
