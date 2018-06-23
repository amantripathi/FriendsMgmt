class User < ApplicationRecord
  include Friendship
  include Subscribe
  
  #validation
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :email, uniqueness: { case_sensitive: false }

end
