if Rails.env.development? || Rails.env.test?
  namespace :dev do
    desc "Create sample data for local development environment"
    task prime: "db:setup" do
      # ----- configuration
      NUM_CHARISMS_TO_KEEP = 3
      NUM_QUESTIONS_PER_CHARISM_TO_KEEP = 2
      DEFAULT_ORGANIZATION_NAME = "St. Example Parish"
      DEFAULT_USER_EMAIL = "admin@example.com"
      DEFAULT_USER_PASSWORD = "password"

      # ----- organization
      puts "*** Creating default organization: '#{DEFAULT_ORGANIZATION_NAME}''"
      organization = Organization.where(name: DEFAULT_ORGANIZATION_NAME).first_or_create

      # ----- user
      puts "*** Creating default user: email = #{DEFAULT_USER_EMAIL}, password = #{DEFAULT_USER_PASSWORD}"
      User.where(email: DEFAULT_USER_EMAIL).first_or_initialize.tap do |user|
        user.first_name = "Admin"
        user.last_name = "Admin"
        user.password = DEFAULT_USER_PASSWORD
        user.organizations << organization
        user.save!
      end

      # ----- web link
      puts "*** Creating web link: '#{WebLink::DEFAULT_GROUP_NAME}'"
      WebLink.where(name: WebLink::DEFAULT_GROUP_NAME, survey: Survey.last).first_or_initialize.tap do |web_link|
        web_link.organization = organization
        web_link.save!
      end

      # ----- decrease amount of questions in development
      puts "*** Decreasing the number of charisms to #{NUM_CHARISMS_TO_KEEP}, each with #{NUM_QUESTIONS_PER_CHARISM_TO_KEEP} questions"
      charism_questions = Survey.last.questions.group_by(&:charism)

      # ---------- only keep a few questions from each charism
      charism_questions.take(NUM_CHARISMS_TO_KEEP).each do |charism, questions|
        questions.drop(NUM_QUESTIONS_PER_CHARISM_TO_KEEP).each do |q|
          q.destroy
        end
      end

      # --------- delete all the other questions
      charism_questions.drop(NUM_CHARISMS_TO_KEEP).each do |charism, questions|
        questions.each do |q|
          q.destroy
        end
      end

      # ----- create sample opportunities for each charism
      puts "*** Creating opportunity: 'Lector'"
      lector = Opportunity.where(name: "Lector").first_or_create.tap do |opportunity|
        opportunity.organization = Organization.first
        opportunity.description = "Deliver the Word of God from the ambo to the congregation."
      end

      puts "*** Creating opportunity: 'Extraordinary Minister of Holy Communion'"
      emhc = Opportunity.where(name: "Extraordinary Minister of Holy Communion").first_or_create.tap do |opportunity|
        opportunity.organization = Organization.first
        opportunity.description = "Assist the celebrant in distributing the Holy Eucharist to the congregation."
      end

      charism_questions.keys.each do |charism|
        charism.opportunities << [lector, emhc].sample(1)
      end
    end
  end
end