class BnrFetcher
  attr_reader :date, :response

  def initialize(date)
    @date = date
    body = Excon.get("http://www.bnr.ro/files/xml/years/nbrfxrates#{date.year}.xml").body
    @response = Nokogiri::XML(body)
  end

  def call
    while !(data = response.css("DataSet Body Cube[date='#{date.to_s}'] Rate[currency='USD']").first)
      @date = date.prev_day
      puts "Trying for #{date.to_s}"
    end
    data.inner_text.to_f
  end
end
