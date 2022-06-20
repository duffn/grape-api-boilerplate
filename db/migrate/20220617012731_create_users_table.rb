class CreateUsersTable < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false
      t.string :username, null: false
      t.string :name
      t.boolean :active, default: true
      t.string :password_digest, null: false
      t.timestamps null: false
    end
  end
end
