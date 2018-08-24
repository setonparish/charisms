#
# This class is responsible for grouping CharismScoreSummary records by its
# respective Charism and providing enumeration on the results.
#
# The idea is for this class to accept filter parameters (like an array of
# WebLink records) and have it return an array of CharismScoreSummary records.
#
class CharismSummary
  include Enumerable

  def initialize(web_links:)
    @web_links = Array(web_links)
  end

  def each(&block)
    summaries.each(&block)
  end

  def all
    summaries
  end

  private

  def summaries
    @summaries ||= charism_scores.group_by(&:charism).map do |charism, charism_scores|
      CharismScoreSummary.new(charism: charism, charism_scores: charism_scores)
    end
  end

  def charism_scores
    CharismScore.joins(survey_response: :web_link)
                .where(survey_responses: { web_link: @web_links })
                .includes(:charism, :respondent)
                .order(score: :desc)
  end
end