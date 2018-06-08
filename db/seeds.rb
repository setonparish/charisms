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

Survey.where(name: "Spiritual Gifts").first_or_initialize do |survey|
  puts "Creating survey '#{survey.name}' with default questions."

  CSV.foreach(Rails.root.join("docs/data/questions.csv"), headers: true) do |row|
    survey.questions.build(text: row[0].chomp, charism: Charism.find_by!(name: row[1]))
  end
  survey.save!
end
