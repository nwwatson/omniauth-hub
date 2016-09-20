class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.integer :uid
      t.string :email
      t.string :name
      t.string :status
      t.boolean :is_organization, default: false
      t.boolean :is_admin,        default: false

      t.timestamps
    end
    
    add_index :users, :uid, unique: true
  end
end
