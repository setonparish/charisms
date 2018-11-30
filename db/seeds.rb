require "csv"

# All data in this file is necessary in all environments that this application runs.
# If you are looking for a quick way to get development up and running, you are probably
# looking for `rake dev:prime`

# ----- charisms
puts "*** Loading charisms"
CSV.foreach(Rails.root.join("docs/data/charisms.csv"), headers: true, encoding: "windows-1251:utf-8") do |row|
  Charism.where(name: row["Charism"]).first_or_initialize.tap do |charism|
    charism.description = row["Description"]
    charism.save!
  end
end

# ----- default survey
puts "*** Loading survey with default questions"
Survey.where(name: Survey::DEFAULT_NAME).first_or_initialize do |survey|
  CSV.foreach(Rails.root.join("docs/data/questions.csv"), headers: true) do |row|
    survey.questions.build(text: row[0].chomp, charism: Charism.find_by!(name: row[1]))
  end
  survey.save!
end