# Preface
This SDK is still a work in progress and, as such, not all endpoints have been implemented

# Configuration

Using a block
```ruby
EPCC.configure do |config|
  config.api_endpoint = 'https://api.moltin.com'
  config.client_id = 'xxx'
  config.client_secret = ENV['CLIENT_SECRET']
end
```

`ENV` variables are also an accepted way to configure values such as `client_secret`, meaning you don't need to specify the configuration above
```ruby
ENV['EPCC_API_ENDPOINT'] = 'https://api.moltin.com'
ENV['EPCC_CLIENT_ID'] = 'xxx'
ENV['EPCC_CLIENT_SECRET'] = 'xxx'
```

# Initialization
```ruby
client = EPCC::Client.new
# or
client = EPCC::Client.new({ client_id: 'xxx', client_secret: 'xxx' })
# or
client = EPCC::Client.new({ grant_type: 'implicit' })
```

# Authentication
```ruby
client.authenticate 
```

# Usage
Instance methods for all resources are available on the client

```ruby
products = client.products
product = client.product('uuid')
```

Plural methods that return lists of resources also accept pagination options and filters

# Built In Resources
It is also possible to use in built model-esque resources. This enables you to ensure resources are valid before using them.
```ruby
product = EPCC::Resources::Product.new({
  name: 'Product',
})
product.valid?
product.create
```

# Pagination
```ruby
products = client.products({limit: 100, offset: 10})
```

# Filtering
```ruby
products = client.products({filter: {eq: {sku: 'xyz'}}})
```

# Contributing
* For this repo
* Create a new branch
* Submit PR to merge in to main

All methods for interacting with the API are in `./lib/epcc/client`.

The follow a simple process of using either get, put, post or delete methods defined on the client.

Example: 
```ruby
def products(options = {})
  get('/pcm/products', options)
end
```
