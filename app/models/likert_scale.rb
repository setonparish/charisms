class LikertScale
  OPTIONS = [
    { name: "Strongly Disagree", score: 0 },
    { name: "Somewhat Disagree", score: 1 },
    { name: "Undecided", score: 2 },
    { name: "Somewhat Agree", score: 3 },
    { name: "Strongly Agree", score: 4 },
  ]

  def self.all
    @@all ||= OPTIONS.map do |attrs|
      new(attrs)
    end
  end

  def self.scores
    all.map(&:score)
  end

  attr_accessor :name, :score

  def initialize(name:, score:)
    @name = name
    @score = score
  end
end
