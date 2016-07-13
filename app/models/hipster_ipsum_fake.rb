class HipsterIpsumFake
  def fetch_data
    {
      "text" => "blarg",
      "params" => { "type" => "hipster-greek" }
    }
  end

  def hipster_text
    fetch_data["text"]
  end
end
