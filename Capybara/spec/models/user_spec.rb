require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:cathy) { User.new(username: "cathy", password: "password") }
  #before(:each) do 
  #  create(:user)
  #end

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
  #subject(:user) do User.new(username: "Joey", password: "password")
  #end 
  describe ".find_by_credentials" do
    before {user.save!}
    it "return the user if given good credentials" do
      expect(User.find_by_credentials("Joey", "password")).to eq(user)
    end
    it "return nil if given bad credentials" do
      expect(User.find_by_credentials("Joey", "bad_password")).to eq(nil)
    end
  end
  
  describe 'check_password?' do
    let!(:user) { create(:user) } # "You can use let! to force the method's invocation before each example."
    # https://relishapp.com/rspec/rspec-core/v/2-11/docs/helper-methods/let-and-let

    context "with a valid password" do
        it "should return true" do
            expect(user.check_password?("password")).to be true
        end
    end

    context "with invalid password" do
        it "should return false" do
            expect(user.check_password?("bananaman")).to be false
        end
    end
end

describe 'password incryption' do

    it 'does not save password to the database' do
        # FactoryBot.create(:user, username: 'Harry Potter')
        FactoryBot.create(:harry_potter) 
        # create "Returns a saved User instance"

        user = User.find_by(username: 'Harry Potter')
        expect(user.password).not_to eq('password')
    end

    it 'encrypts password using BCrypt' do 
        expect(BCrypt::Password).to receive(:create).with('abcdef')

        FactoryBot.build(:user, password: 'abcdef')
        # Returns a User instance that's not saved
        # https://www.rubydoc.info/gems/factory_bot/file/GETTING_STARTED.md#build-strategies
    end
end
end
