module Friendship
  extend ActiveSupport::Concern

  included do
    has_and_belongs_to_many :friends, -> {where('relationships.is_friend': true)},
              class_name: "User", join_table: :relationships, foreign_key: :user_id, 
              association_foreign_key: :friend_id
    has_and_belongs_to_many :inverse_friends, -> {where('relationships.is_friend': true)},
              class_name: "User", join_table: :relationships, foreign_key: :friend_id, 
              association_foreign_key: :user_id
  end

   # a user to become a friend. If the operation succeeds, the method returns true, else false
  def make_friend(user)
    return false if user == self || relationship_exist?(find_any_relationship_with(user))
    if relationship = find_any_relationship_with(user)
      relationship.update_attributes(is_friend = true)
    else
      Relationship.new(friend_id: user.id, user_id: self.id, is_friend: true).save
    end
  end

  # get the friend list by user id either is user in user_id or in friend_id in relationship table
  def friend_list
    friends + inverse_friends
  end

  # get the common friend list by based on two users
  def common_friends(user2)
    self.friend_list & user2.friend_list
  end

  # check a user is have any relationship. Method return true when user have already friendship or user is blocked, else false
  def relationship_exist?(relationship)
    relationship && (relationship.is_friend? || relationship.is_blocked?)
  end

   # returns friendship with given user or nil
  def find_any_relationship_with(user)
    friendship = Relationship.where(:user_id => self.id, :friend_id => user.id).first
    if friendship.nil?
      friendship = Relationship.where(:user_id => user.id, :friend_id => self.id).first
    end
    friendship
  end 
end