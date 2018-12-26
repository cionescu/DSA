class InvoiceFetcherJob < ApplicationJob
  queue_as :default

  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
  APPLICATION_NAME = 'Drive API Ruby Quickstart'.freeze
  CREDENTIALS_PATH = Rails.root.join('config', 'credentials.json').freeze
  TOKEN_PATH = Rails.root.join('config', 'token.yaml').freeze
  SCOPE = [Google::Apis::DriveV3::AUTH_DRIVE_METADATA_READONLY, Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY]

  def perform
    # Initialize the API
    service = Google::Apis::DriveV3::DriveService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize

    # List the 10 most recently modified files.
    response = nil
    service.list_files(page_size: 20, fields: 'nextPageToken, files(id, name)', q: "name contains 'Invoice'") do |res, err|
      if err
        puts err
        exit
      else
        response = res
      end
    end
    puts 'No files found' if response.files.empty?
    data = response.files.map do |file|
      get_invoice_date_and_price(file.id, file.name)
    end

    puts data.inspect
  end

  private

  def authorize
    client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: OOB_URI)
      puts 'Open the following URL in the browser and enter the ' \
           "resulting code after authorization:\n" + url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI
      )
    end
    credentials
  end

  def get_invoice_date_and_price(spreadsheet_id, name)
    # Initialize the API
    service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize

    range = 'Invoice (Factura)!A:F'
    response = begin
      service.get_spreadsheet_values(spreadsheet_id, range)
    rescue Google::Apis::ClientError
      return []
    end

    puts 'No data found.' and return if response.values.empty?
    date = Date.parse(response.values[2][5])
    invoice = Invoice.find_or_create_by(invoice_date: date)
    invoice.update!(value_usd: response.values[22][5].gsub(/\D/,'').to_i / 100)
    BnrFetcher.new.perform(invoice.id)
  end
end
