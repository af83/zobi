class CreateFoos < ActiveRecord::Migration
  def change
    create_table :foos do |t|
      t.string :name
      t.string :category
      t.boolean :published
      t.timestamps
    end
  end
end
