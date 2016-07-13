require 'rails_helper'

describe HipsterIpsum, type: :model do
  describe "#fetch_data", vcr: { cassette_name: "hipster_ipsum" } do
    it "returns HTTParty::Response with text" do
      hipster_data = HipsterIpsum.new.fetch_data
      expect(hipster_data.class).to eq HTTParty::Response

      expect(hipster_data["text"]).to be_a String
      expect(hipster_data["text"]).to include "Listicle VHS meggings placeat occaecat"
    end
  end

  describe "#fetch_data" do
    it "returns HTTParty::Response with text" do
      hipster_data = HipsterIpsum.new.fetch_data
      expect(hipster_data.class).to eq HTTParty::Response

      expect(hipster_data["text"]).to be_a String
      expect(hipster_data["text"]).to include "Listicle VHS meggings placeat occaecat"
    end
  end
end
