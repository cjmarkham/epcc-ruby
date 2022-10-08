require 'epcc'

EPCC.configure do |c|
  c.client_id = 'xxx'
  c.client_secret = 'xxx'
  c.response_type = 'struct'
end

client = EPCC::Client.new
client.authenticate

product = EPCC::Resources::Product.new({
  name: 'Product 1',
})

puts product.valid?

product.create

puts product.success?

puts product.errors
puts product.data
