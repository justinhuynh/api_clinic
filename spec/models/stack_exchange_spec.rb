require 'rails_helper'

describe StackExchange do
  let(:stack_exchange) { StackExchange.new("stackoverflow", 1) }

  describe "#questions", vcr: { cassette_name: "stack_exchange_questions" } do
    it "should return a list of questions" do
      questions = stack_exchange.questions

      expect(questions.code).to eq 200
      expect(questions).to_not be nil
      expect(questions["items"]).to be_an Array
      expect(questions["items"].count).to eq 30
    end
  end

  describe "#users", vcr: { cassette_name: "stack_exchange_users" } do
    it "should return a list of users" do
      users = stack_exchange.users

      expect(users).to_not be nil
      expect(users["items"]).to be_an Array
      expect(users["items"].count).to eq 30
    end
  end
end
