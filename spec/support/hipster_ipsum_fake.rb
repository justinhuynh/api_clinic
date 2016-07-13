class HipsterIpsumFake
  def fetch_data
    self
  end

  def class
    HTTParty::Response
  end

  def [](key)
    "Listicle VHS meggings placeat occaecat"
  end
end
