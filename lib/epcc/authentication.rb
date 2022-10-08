require 'epcc/request'

module EPCC
  # Module for authenticating against the API
  module Authentication
    def authenticate(options = {})
      grant_type = options[:grant_type] || 'client_credentials'
      post_options = {
        body: {
          grant_type: 'client_credentials',
          client_id: EPCC.client_id,
        },
        headers: {
          'Content-Type': 'x-www-form-urlencoded',
        }
      }

      post_options[:body][:client_secret] = EPCC.client_secret if grant_type != 'password'

      response = post('/oauth/access_token', post_options)

      access_token = nil
      access_token = response.access_token if EPCC.response_type == 'struct'
      access_token = response['access_token'] unless EPCC.response_type == 'struct'

      instance_variable_set('@access_token', access_token)
    end
  end
end
