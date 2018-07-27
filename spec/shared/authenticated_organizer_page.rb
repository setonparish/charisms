RSpec.shared_examples "authenticated_organizer_page" do |params|
  #
  # Call the controller action using the correct HTTP verb and
  # assert the correct response behavior.
  #
  Array(params[:actions]).each do |action|
    http_verbs = {
       index: :get,
       update: :post,
       show: :get,
     }

    it "redirects to login page" do
      self.send(http_verbs.fetch(action), action)
      expect(response).to redirect_to(:login)
    end
  end
end