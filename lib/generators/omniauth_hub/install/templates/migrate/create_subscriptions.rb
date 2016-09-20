class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.intiger :sid
      t.integer :uid
      t.integer :plan_id
      t.string :plan_name
      t.string :plan_key
      t.date :started_at
      t.date :canceled_at

      t.timestamps
    end
  end
end
