require 'epcc'

EPCC.configure do |c|
  c.client_id = 'xxx'
  c.client_secret = 'xxx'
  c.response_type = 'struct'
end

client = EPCC::Client.new
client.authenticate

product = client.create_product({
  data: {
    type: 'product',
    attributes: {
      name: 'Product Name',
      commodity_type: 'digital',
      sku: 'product',
      slug: 'product',
      status: 'live',
    }
  }
})

client.delete_product(product.data.id)
