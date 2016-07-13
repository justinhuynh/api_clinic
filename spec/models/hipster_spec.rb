require 'rails_helper'

describe Hipster do
  let(:hipster) { Hipster.new }

  describe "#text" do
    it "returns hipster text" do
      expect(hipster.text).to include "blarg"
    end
  end

  describe "#type" do
    it "returns hipster type" do
      expect(hipster.type).to eq "hipster-greek"
    end
  end
end
