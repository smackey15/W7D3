require 'rails_helper'

RSpec.describe User, type: :model do

  #subject(:cathy) { User.create(username: "cathy", password: "password") }

  it { should validate_presence_of(:username)}
  it { should validate_presence_of(:passowrd_digest)}
  it { should validate_length_of(:password).is_at_least(6)}
  it { should have_many(:goals)}

  describe "uniqueness" do 
    before(:each) do 
      create(:user)
    end
    it { should validate_uniqueness_of(:username)}
    it { should validate_uniqueness_of(:session_token)}
  end
  #pending "add some examples to (or delete) #{__FILE__}"
  subject(:user) do User.new(username: "Joey", pasword: "password")
  end 
  describe ".find_by_credentials" do
    before {user.save!}
    it "return the user if given good credentials" do
      expect(User.find_by_credentials("Joey", "password")).to eq(user)
    end
    it "return nil if given bad credentials" do
      expect(User.find_by_credentials("Joey", "bad_password")).to eq(nil)
    end
  end 
end

