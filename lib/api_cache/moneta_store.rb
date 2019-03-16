require 'digest/md5'

class APICache
  class MonetaStore < APICache::AbstractStore
    def initialize(store)
      @moneta = store
    end

    # Set value. Returns true if success.
    def set(key, value)
      key = hash_key(key)
      @moneta[key] = value
      @moneta["#{key}_created_at"] = Time.now
      true
    end

    # Get value.
    def get(key)
      key = hash_key(key)
      @moneta[key]
    end

    # Delete value.
    def delete(key)
      key = hash_key(key)
      @moneta.delete(key)
    end

    # Does a given key exist in the cache?
    def exists?(key)
      key = hash_key(key)
      @moneta.key?(key)
    end

    def created_at(key)
      key = hash_key(key)
      @moneta["#{key}_created_at"]
    end

    private

      # use key's digest as key name to avoid error "File name too long @ rb_file_s_rename" when using File store
      def hash_key(key)
        if @moneta.adapter.is_a?(Moneta::Adapters::File)
          Digest::MD5.hexdigest(key)
        else
          key
        end
      end
  end
end
