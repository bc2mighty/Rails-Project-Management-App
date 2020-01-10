class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :userid
      t.string :fullname
      t.string :email
      t.string :password_digest
      t.boolean :isAdmin, default: false

      t.timestamps
    end
  end
end
