require "csv"

Survey.where(name: "Spiritual Gifts").first_or_initialize do |survey|
  puts "Creating survey '#{survey.name}' with default questions."

  CSV.foreach(Rails.root.join("docs/data/questions.csv"), headers: true) do |row|
    survey.questions.build(text: row[0].chomp)
  end
  survey.save!
end
