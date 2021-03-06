class BnrFetcher < ApplicationJob
  queue_as :default
  attr_reader :invoice

  def perform(invoice_id)
    @invoice = Invoice.find(invoice_id)
    date = invoice.invoice_date.prev_day
    while !(data = response.css("DataSet Body Cube[date='#{date.to_s}'] Rate[currency='USD']").first)
      date = date.prev_day
      puts "Trying for #{date.to_s}"
      if (invoice.invoice_date - date).to_i > 10
        puts "❌ Gone too far. Breaking"
        return
      end
    end
    invoice.update!(exchange_date: date, exchange_rate: data.inner_text.to_f)
  end

  private

  def response
    @_response ||= invoice.yield_self do |invoice|
      "https://www.bnr.ro/files/xml/years/nbrfxrates#{invoice.invoice_date.year}.xml"
    end.yield_self{ |uri| Excon.get(uri).body }
      .yield_self{ |body| Nokogiri::XML(body) }
  end
end
