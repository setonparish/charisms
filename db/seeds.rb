require "csv"

[
  "Administration",
  "Apostle",
  "Caregiver",
  "Craftsmanship",
  "Discernment",
  "Evangelist",
  "Exhortation",
  "Faith",
  "Giving",
  "Healing",
  "Hospitality",
  "Intercession",
  "Knowledge",
  "Mercy",
  "Missionary",
  "Musician",
  "Pastor",
  "Power (Deeds of)",
  "Prophet",
  "Serving",
  "Teacher",
  "Tongues",
  "Wisdom"
].each do |charism_name|
  Charism.where(name: charism_name).first_or_create! do |charism|
    puts "Creating default charism '#{charism.name}'."
  end
end

default_survey = Survey.where(name: "Spiritual Gifts").first_or_initialize do |survey|
  puts "Creating survey '#{survey.name}' with default questions."

  CSV.foreach(Rails.root.join("docs/data/questions.csv"), headers: true) do |row|
    survey.questions.build(text: row[0].chomp, charism: Charism.find_by!(name: row[1]))
  end
  survey.save!
end

# create a default DistributionGroup
DistributionGroup.where(name: "Disconnected Responses", survey: default_survey).first_or_create!

if Rails.env.development?
  NUM_CHARISMS_TO_KEEP = 3
  NUM_QUESTIONS_PER_CHARISM_TO_KEEP = 2
  puts "Decreasng the number of charisms to #{NUM_CHARISMS_TO_KEEP}, each with #{NUM_QUESTIONS_PER_CHARISM_TO_KEEP} questions"

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
