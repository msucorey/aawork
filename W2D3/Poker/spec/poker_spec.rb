require 'rspec'
require 'game'
require 'hand'
require 'player'
require 'deck'
require 'card'

describe "poker" do

  describe "card" do
    subject(:test_card) { Card.new(:club, :king)}

    describe "#initialize" do

      it "sets the suit" do
        expect(test_card.suit).to eq(:club)
      end

      it "sets the face value" do
        expect(test_card.value).to eq(:king)
      end
    end

  end

  describe "deck" do
    subject!(:test_deck) { Deck.new }

    describe "#initialize" do

      it "builds an array of 52 cards" do
        expect(test_deck.cards.size).to eq(52)
      end

      it "holds no duplicates" do
        expect(test_deck.cards).to be_uniq
      end

    end

    describe "#shuffle!" do

      it "shuffles! the deck" do
        expect(test_deck.cards).to receive(:shuffle)
      end

    end

    describe "#draw" do

      it "returns the top card" do
        top_card = test_deck.cards.last
        expect(test_deck.draw).to eq(top_card)
      end

      it "removes the top card from the deck" do
        top_card = test_deck.cards.last
        test_deck.draw
        expect(test_deck.cards.include?(top_card)).to be false
      end

    end

    describe "#reset" do

      it "restores the deck to a complete deck" do
        test_deck.draw
        test_deck.draw
        test_deck.reset
        expect(test_deck.cards.size).to eq(52)
      end

      it "calls shuffle after restoring deck" do
        test_deck.draw
        test_deck.draw
        test_deck.reset
        expect(test_deck).to receive(:shuffle!)
      end

    end

  end

end
