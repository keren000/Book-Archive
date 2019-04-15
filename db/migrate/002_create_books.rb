class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :category
      t.date :date
      t.string :format
      #belongs to user
      t.integer :user_id
    end
  end
end
