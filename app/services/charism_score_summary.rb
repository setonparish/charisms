#
# This class is responsible for providing convenience methods on an array of
# CharismScore records.
#
class CharismScoreSummary
  include Enumerable

  attr_reader :charism, :charism_scores

  def initialize(charism:, charism_scores:)
    @charism = charism
    @charism_scores = Array(charism_scores)
  end

  def name
    charism.name
  end

  def total
    charism_scores.sum(&:score)
  end

  def each(&block)
    block.call(charism_scores)
  end

  def <=>(other)
    self.total <=> other.total
  end
end