class HipsterIpsum
  include HTTParty
  base_uri "http://hipsterjesus.com"

  def fetch_data
    self.class.get("/api")
  end

  def hipster_text
    fetch_data["text"]
  end
end
