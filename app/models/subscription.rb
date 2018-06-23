class Subscription < ApplicationRecord
  #validation
  validates :subscriber_id, uniqueness: { scope: [:user_id], message: 'Relationship Exists'}

  enum status: [:allowed, :blocked]

  Subscription.statuses.each do |status_type|
    define_method("#{status_type}?") do
      self.status == status_type
    end
  end
end
