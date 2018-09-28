RSpec.shared_examples "authenticated_organizer_page" do |params|
  #
  # Call the controller action using the correct HTTP verb and
  # assert the correct response behavior.
  #
  Array(params[:actions]).each do |action|
    http_verbs = {
       index: :get,
       new: :get,
       create: :post,
       edit: :get,
       update: :post,
       show: :get,
     }

    it "redirects to login page" do
      allow_any_instance_of(described_class).to receive(:current_user).and_return(nil)

      self.send(http_verbs.fetch(action), action, params: { id: 1 })
      expect(response).to redirect_to(:login)
    end
  end
end