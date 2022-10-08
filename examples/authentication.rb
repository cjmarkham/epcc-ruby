# Inline or you can use dotenv
ENV['EPCC_CLIENT_SECRET'] = 'xxx'

require 'epcc'

EPCC.configure do |c|
  c.client_id = 'TwT89pcp87byZzrpBjf33oeISZoSMSH2dQakaTqOOA'
  c.client_secret = 'xxx' # If you like to live life on the edge
end

client = EPCC::Client.new
client.authenticate
