# frozen_string_literal: true

require 'epcc/request'

RSpec.describe(EPCC::Request) do
  klass = Class.new
  klass.extend(described_class)

  describe('get') do
    it('works with default options') do
      expect(HTTParty).to receive(:send).with(
        'get',
        '/pcm/products?',
        {
          headers: {
            Authorization: 'Bearer: ',
            Accept: 'application/json',
            'Content-Type' => 'application/json',
            'X-EPCC-SDK': 'Ruby',
            'X-EPCC-SDK-VERSION': EPCC::VERSION,
          }
        }
      ).and_return(OpenStruct.new({
        code: 200,
        body: {}.to_json,
      }))

      klass.get('/pcm/products')
    end

    it('works with custom headers') do
      expect(HTTParty).to receive(:send).with(
        'get',
        '/pcm/products?',
        {
          headers: {
            Authorization: 'Bearer: ',
            Accept: 'application/json',
            'Content-Type': 'x-www-form-urlencoded',
            'X-EPCC-SDK': 'Ruby',
            'X-EPCC-SDK-VERSION': EPCC::VERSION,
          }
        }
      ).and_return(OpenStruct.new({
        code: 200,
        body: {}.to_json,
      }))

      klass.get(
        '/pcm/products',
        {
          headers: {
            'Content-Type': 'x-www-form-urlencoded',
          }
        }
      )
    end
  end

  describe('post') do
    it('works with a body') do
      expect(HTTParty).to receive(:send).with(
        'post',
        '/pcm/products?',
        {
          headers: {
            Authorization: 'Bearer: ',
            Accept: 'application/json',
            'Content-Type' => 'application/json',
            'X-EPCC-SDK': 'Ruby',
            'X-EPCC-SDK-VERSION': EPCC::VERSION,
          },
          body: {
            data: {
              type: 'product',
              attributes: {
                name: 'Product',
              }
            }
          }.to_json,
        }
      ).and_return(OpenStruct.new({
        code: 201,
        body: {}.to_json,
      }))

      klass.post(
        '/pcm/products',
        {
          body: {
            data: {
              type: 'product',
              attributes: {
                name: 'Product',
              }
            }
          }
        }
      )
    end
  end

  describe('filter_from_hash') do
    it('returns an empty string when no filters specified') do
      res = klass.filter_from_hash(nil)
      expect(res).to eq('')
    end

    it('returns all filters of the array') do
      hash = {
        eq: {
          name: 'Foo',
          sku: 'bar',
        },
      }
      res = klass.filter_from_hash(hash)
      expect(res).to eq('filter=eq(name,Foo):eq(sku,bar)')
    end

    it('returns all filters') do
      hash = {
        eq: {
          name: 'Foo',
          sku: 'bar',
        },
        like: {
          status: 'live',
        }
      }
      res = klass.filter_from_hash(hash)
      expect(res).to eq('filter=eq(name,Foo):eq(sku,bar):like(status,live)')
    end
  end

  describe('pagination_from_hash') do
    it('returns an empty string when no pagination specified') do
      res = klass.pagination_from_hash(nil)
      expect(res).to eq('')
    end

    it('returns correct pagination from hash') do
      hash = {
        limit: 10,
        offset: 0,
      }
      res = klass.pagination_from_hash(hash)
      expect(res).to eq('page[limit]=10&page[offset]=0')
    end

    it('returns correct pagination for just limit') do
      hash = {
        limit: 10,
      }
      res = klass.pagination_from_hash(hash)
      expect(res).to eq('page[limit]=10')
    end

    it('returns correct pagination for just offset') do
      hash = {
        offset: 0,
      }
      res = klass.pagination_from_hash(hash)
      expect(res).to eq('page[offset]=0')
    end

    it('ignores non pagination keys') do
      hash = {
        offset: 0,
        foo: 'bar',
      }
      res = klass.pagination_from_hash(hash)
      expect(res).to eq('page[offset]=0')
    end
  end

  describe('url_from_options') do
    it('returns a url with no options') do
      res = klass.url_from_options('/pcm/products')
      expect(res).to eq("#{res.instance_variable_get('@api_endpoint')}/pcm/products?")
    end

    it('returns a url with filters') do
      res = klass.url_from_options(
        '/pcm/products',
        {
          filter: {
            eq: {
              name: 'Foo',
            },
          },
        },
      )
      expect(res).to eq("#{res.instance_variable_get('@api_endpoint')}/pcm/products?filter=eq(name,Foo)")
    end

    it('returns a url with pagination') do
      res = klass.url_from_options(
        '/pcm/products',
        {
          pagination: {
            limit: 10,
            offset: 0,
          },
        },
      )
      expect(res).to eq("#{res.instance_variable_get('@api_endpoint')}/pcm/products?page[limit]=10&page[offset]=0")
    end
  end
end
