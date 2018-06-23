class Relationship < ApplicationRecord
  belongs_to :user

  #validation
  validates :friend_id, uniqueness: { scope: [:user_id, :is_friend, :is_subscribed, :is_blocked], message: 'Relationship Exists'}

  
end
