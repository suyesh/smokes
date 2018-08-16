module Smokes
  module Utils
    def symbolize_hash(hash)
      hash.each_with_object({}) do |(key, value), result|
        new_key = case key
                  when String then key.to_sym
                  else key
                  end
        new_value = case value
                    when Hash then symbolize_keys(value)
                    else value
                    end
        result[new_key] = new_value
      end
    end
  end
end
