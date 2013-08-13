class CacheVersion
   def self.method_missing(method, *args)
    method_name = method.to_s
    super(method, *args)
  rescue NoMethodError
    if method_name =~ /=$/
      var_name = method_name.gsub('=', '')
      key = CacheVersion.mk_key(var_name)
      value = args.first.to_s
      # save
      Rails.cache.write(key, value)
    else
      key = CacheVersion.mk_key(method)
      Rails.cache.read(key)
    end
  end

  def self.mk_key(key)
    "cache_version:#{key}"
  end
end
