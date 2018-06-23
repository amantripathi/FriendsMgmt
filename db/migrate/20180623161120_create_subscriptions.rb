class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.integer :subscriber_id
      t.references :user, foreign_key: true
      t.integer :status, default: 0
      t.timestamps
    end
    add_index(:subscriptions, [:user_id, :subscriber_id])
  end
end
