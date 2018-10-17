# ----- decrease amount of questions in development
if Rails.env.development?
  NUM_CHARISMS_TO_KEEP = 3
  NUM_QUESTIONS_PER_CHARISM_TO_KEEP = 2
  puts "Decreasing the number of charisms to #{NUM_CHARISMS_TO_KEEP}, each with #{NUM_QUESTIONS_PER_CHARISM_TO_KEEP} questions"

  charism_questions = Survey.last.questions.group_by(&:charism)

  # only keep a few questions from each charism
  charism_questions.take(NUM_CHARISMS_TO_KEEP).each do |charism, questions|
    questions.drop(NUM_QUESTIONS_PER_CHARISM_TO_KEEP).each do |q|
      q.destroy
    end
  end

  # delete all the other questions
  charism_questions.drop(NUM_CHARISMS_TO_KEEP).each do |charism, questions|
    questions.each do |q|
      q.destroy
    end
  end
end
