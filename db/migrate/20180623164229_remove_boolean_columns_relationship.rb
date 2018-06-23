class RemoveBooleanColumnsRelationship < ActiveRecord::Migration[5.2]
  def change
    remove_columns :relationships, :is_subscribed
    remove_columns :relationships, :is_blocked
    remove_columns :relationships, :is_friend
  end
end
