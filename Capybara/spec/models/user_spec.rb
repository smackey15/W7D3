require 'rails_helper'

RSpec.describe User, type: :model do
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
end

