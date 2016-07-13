class Hipster
  @@api = HipsterIpsum
  cattr_accessor :api

  attr_reader :text, :type

  def initialize
    @text = text
    @type = type
  end

  def text
    get_hipster_data["text"]
  end

  def type
    get_hipster_data["params"]["type"]
  end

  private

  def get_hipster_data
    @hipster_data ||= api.new.fetch_data
  end
end
