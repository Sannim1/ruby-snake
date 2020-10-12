require "spec_helper"

describe Food do
  let(:food_item) { Food.new(25, 25) }

  describe "#new" do
    it "instantiates a food item at the right co-ordinates" do
      expect(food_item).to_not be_nil
      expect(food_item.x).to_not be_nil
      expect(food_item.y).to_not be_nil
    end
  end

  describe "#coordinates" do
    it "returns the co-ordinates of the food's position" do
      expect(food_item.coordinates).to eq([food_item.x, food_item.y])
    end
  end
end
