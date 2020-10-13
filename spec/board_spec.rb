require "spec_helper"

RSpec.describe RubySnake::Board do
  describe "#new" do
    it "instantiates a new board" do
      expect(described_class.new(40, 40).board).to_not be_nil
    end
  end

  describe "#create_board" do
    let(:gameboard) { described_class.new(40, 40) }

    it "returns an array" do
      expect(gameboard.board).to be_instance_of(Array)
    end

    it "returns a board with the correct size" do
      expect(gameboard.board.size).to eq(40)
      expect(gameboard.board.map(&:size).uniq).to eq([40])
    end

    it "returns an empty board" do
      expect(gameboard.board.flatten.uniq).to eq([described_class::DOT])
    end
  end
end
