RSpec.configure do |config|
  #
  # Allow an rspec tag of `:authenticated_user` to fake the controller into thinking
  # it has a current_user.
  #
  config.before(:each, :authenticated_user) do |obj|
    user = FactoryBot.build(:user)
    allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
  end
end