require "csv"

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
    survey.questions.build(text: row[0].chomp, charism: Charism.find_by!(name: row[1]))
  end
  survey.save!
end

# ----- user
user = User.first_or_initialize(email: "admin@example.com").tap do |user|
  user.first_name = "Admin"
  user.last_name = "Admin"
  user.password = "password"
  user.save!
end

# ----- web link
WebLink.where(name: WebLink::DEFAULT_GROUP_NAME, survey: default_survey).first_or_initialize.tap do |web_link|
  web_link.user = user
  web_link.save!
end
