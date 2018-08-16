module Smokes
  def symbolize_hash(hash)
    hash.each_with_object({}) { |(k, v), memo| memo[k.to_sym] = v }
  end
end
