class Relationship < ApplicationRecord
  belongs_to :user

  #validation
  validates :friend_id, uniqueness: { scope: [:user_id], message: 'Relationship Exists'}

  
end
