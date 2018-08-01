
# ----- charisms
require "csv"
charisms = CSV.foreach(Rails.root.join("docs/data/charisms.csv"), headers: true, encoding: "windows-1251:utf-8") do |row|
  Charism.where(name: row["Charism"]).first_or_initialize.tap do |charism|
    charism.description = row["Description"]
    charism.save!
  end
end

# ----- default survey
default_survey = Survey.where(name: Survey::DEFAULT_NAME).first_or_initialize do |survey|
  puts "Creating survey '#{survey.name}' with default questions."

  CSV.foreach(Rails.root.join("docs/data/questions.csv"), headers: true) do |row|
    puts row[1]
    survey.questions.build(text: row[0].chomp, charism: Charism.find_by!(name: row[1]))
  end
  survey.save!
end

# ----- user
user = User.first_or_initialize(email: "padre@example.com").tap do |user|
  user.first_name = "Padre"
  user.last_name = "Pio"
  user.email = "padre@example.com"
  user.password = "password"
  user.save!
end

# ----- web link
WebLink.where(name: WebLink::DEFAULT_GROUP_NAME, survey: default_survey).first_or_initialize.tap do |web_link|
  web_link.user = user
  web_link.save!
end

# ----- decrease amount of questions in development
if Rails.env.development?
  NUM_CHARISMS_TO_KEEP = 3
  NUM_QUESTIONS_PER_CHARISM_TO_KEEP = 2
  puts "Decreasing the number of charisms to #{NUM_CHARISMS_TO_KEEP}, each with #{NUM_QUESTIONS_PER_CHARISM_TO_KEEP} questions"

  charism_questions = Survey.last.questions.group_by(&:charism)

  # only keep a few questions from each charism
  charism_questions.take(NUM_CHARISMS_TO_KEEP).each do |charism, questions|
    questions.drop(NUM_QUESTIONS_PER_CHARISM_TO_KEEP).each do |q|
      q.question_order.destroy
      q.destroy
    end
  end

  # delete all the other questions
  charism_questions.drop(NUM_CHARISMS_TO_KEEP).each do |charism, questions|
    questions.each do |q|
      q.question_order.destroy
      q.destroy
    end
  end
end
