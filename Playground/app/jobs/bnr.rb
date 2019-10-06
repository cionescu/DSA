class Bnr
  def perform date
    body = response(date)
    (date.end_of_month - 10.days..date.end_of_month).map do |date|
      [date, body.css("DataSet Body Cube[date='#{date.to_s}'] Rate[currency='USD']").first&.inner_text.to_f]
    end.select{ |item| item.last != 0.0 }.sort_by(&:second)
  end

  def response(date)
    @_response ||= "https://www.bnr.ro/files/xml/years/nbrfxrates#{date.year}.xml"
      .yield_self{ |uri| Excon.get(uri).body }
      .yield_self{ |body| Nokogiri::XML(body) }
  end
end
