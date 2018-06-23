module Subscribe
  extend ActiveSupport::Concern

  included do
    has_and_belongs_to_many :subscribers, -> {where('subscriptions.status': Subscription.statuses[:allowed])},
              class_name: "User", join_table: :subscriptions, foreign_key: :user_id, 
              association_foreign_key: :subscriber_id
    has_and_belongs_to_many :blocked_outs, -> {where('subscriptions.status': Subscription.statuses[:blocked])},
              class_name: "User", join_table: :subscriptions, foreign_key: :subscriber_id, 
              association_foreign_key: :user_id
  end

  # a user to become a subscriber. If the operation succeeds, the method returns true, else false
  def subscribe(user)
    return false if user == self
    if subscription = find_any_subscription_with(user)
      subscription.update_attributes(status: Subscription.statuses[:allowed])
    else
      Subscription.new(subscriber_id: user.id, user_id: self.id).save
    end
  end

  # a user to become a subscriber. If the operation succeeds, the method returns true, else false
  def block(user)
    return false if user == self
    if subscription = find_any_subscription_with(user)
      subscription.update_attributes(status: Subscription.statuses[:blocked])
    else
      Subscription.new(subscriber_id: user.id, user_id: self.id, status: Subscription.statuses[:blocked]).save
    end
  end

  #check for the subscription existance
  def find_any_subscription_with(user)
    Subscription.where(:user_id => self.id, :subscriber_id => user.id).first
  end

  #retrive all reciever condition 1. should be subscribed or 2. in friend list and not blocked by other user
  def get_recipient_send_message(text)
    (subscribers + friend_list) - blocked_outs
  end

  #check before frindship either user is blocked or not
  def is_subscrition_blocked?(user)
    find_any_subscription_with(user).try(:blocked?) || reverse_blocked(user).try(:blocked?)
  end

  #check for the subscription existance
  def reverse_blocked(user)
    Subscription.where(:subscriber_id => self.id, :user_id => user.id).first
  end
end