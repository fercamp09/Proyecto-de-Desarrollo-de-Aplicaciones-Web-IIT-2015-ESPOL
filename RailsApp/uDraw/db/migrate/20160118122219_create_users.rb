class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :facebook
      t.string :twitter
      t.string :google
      t.string :espol
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
