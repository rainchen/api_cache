require 'spec_helper'

require 'moneta'

describe APICache::MonetaStore do
  let(:cache) { Moneta.new(:Memcached) }
  let(:store) { APICache::MonetaStore.new(cache) }

  include_examples "generic store"

  it "should be able to fetch a long url using file store" do
    url = "http://www.google.com/?q=this-is-a-#{"very"*1000}-long-string"
    stub_request(:get, url).to_return(:body => "Google")

    # store to file
    APICache.store = Moneta.new(:File, dir: 'tmp/cache/moneta')

    cache = APICache.get(url)
    cache.should_not == nil
    # get from store
    APICache.get(url).should == cache
  end
end
