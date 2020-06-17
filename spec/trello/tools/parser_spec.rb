# frozen_string_literal: true

require 'rspec'
require 'trello/tools/parser'

RSpec.describe Trello::Tools::Parser do
  subject(:actions) { Trello::Tools::Parser.parse(payload) }

  let(:action_type) { 'updateCard' }
  let(:card_id) { '5ee9aacad92bb62c858374dd' }
  let(:date) { '2020-06-17T05:32:33.939Z' }
  let(:payload) do
    [
      {
        "data": {
          "old": {
            "desc": ''
          },
          "card": {
            "desc": 'This is my first card so I can test Trello API.',
            "id": card_id,
            "name": 'Hallo, world!',
            "idShort": 1,
            "shortLink": 'gigQA92e'
          }
        },
        "type": action_type,
        "date": '2020-06-17T05:32:33.939Z'
      }
    ]
  end

  describe '#parse' do
    it "parses Trello's JSON in a list of actions" do
      expect(actions.size).to eq(1)
    end

    it 'sets the type' do
      expect(actions.first.type).to eq(action_type)
    end

    it "sets the card's ID" do
      expect(actions.first.card_id).to eq(card_id)
    end

    it 'sets the date' do
      expect(actions.first.date.iso8601).to eq(Date.parse(date).iso8601)
    end
  end
end
