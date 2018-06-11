require "rails_helper"

describe LikertScale do
  describe ".all" do
    it "returns all the likert scales" do
      expect(LikertScale.all.size).to eq(5)
    end
  end

  describe ".scores" do
    it "returns the correct numerical valud" do
      expect(LikertScale.scores).to eq((0..4).to_a)
    end
  end
end

