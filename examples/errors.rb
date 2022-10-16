require 'epcc'

EPCC.configure do |c|
  c.client_id = 'TwT89pcp87byZzrpBjf33oeISZoSMSH2dQakaTqOOA'
end

client = EPCC::Client.new
client.authenticate

begin
  client.create_pricebook(
    data: {
      type: 'pricebook',
      attributes: {
        name: 'Pricebook 1',
      }
    }
  )
rescue EPCC::ClientError => e
  p e.status
  p e.errors
end

# Alternatively, you can rescue from specific errors

product = begin
  client.product(uuid)
rescue EPCC::NotFound => e
  # Do something
end
