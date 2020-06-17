# frozen_string_literal: true

require 'rspec'
require 'trello/tools/parser'

RSpec.describe Trello::Tools::Parser do
  subject(:actions) { Trello::Tools::Parser.parse(payload) }

  let(:action_type) { 'updateCard' }
  let(:card_id)     { '5ee9aacad92bb62c858374dd' }
  let(:date)        { '2020-06-17T05:32:33.939Z' }
  let(:list_id) { '5ee9aac43ce8d672506c4e8c' }
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
          },
          "list": {
            "id": list_id,
            "name": 'Backlog'
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

    it "sets the list's ID" do
      expect(actions.first.list_id).to eq(list_id)
    end

    it "sets the old list's ID to nil" do
      expect(actions.first.old_list_id).to be_nil
    end

    context "when the old list's ID is available" do
      let(:old_list_id) { '5ee9aac43ce8d672506c4e8c' }

      before do
        payload.first[:data][:old][:idList] = old_list_id
      end

      it "sets the old list's ID" do
        expect(actions.first.old_list_id).to eq(old_list_id)
      end
    end
  end
end
