require 'spec_helper'

describe UserRelationshipsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

  before { sign_in user, no_capybara: true }

  describe "creating a relationship with Ajax" do

    it "should increment the UserRelationship count" do
      expect do
        xhr :post, :create, user_relationship: { followed_id: other_user.id }
      end.to change(UserRelationship, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, :create, user_relationship: { followed_id: other_user.id }
      expect(response).to be_success
    end
  end

  describe "destroying a relationship with Ajax" do

    before { user.follow!(other_user) }
    let(:user_relationship) do
      user.user_relationships.find_by_followed_id(other_user.id)
    end

    it "should decrement the UserRelationship count" do
      expect do
        xhr :delete, :destroy, id: user_relationship.id
      end.to change(UserRelationship, :count).by(-1)
    end

    it "should respond with success" do
      xhr :delete, :destroy, id: user_relationship.id
      expect(response).to be_success
    end
  end
end