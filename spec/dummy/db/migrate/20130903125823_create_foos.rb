# encoding: utf-8
class CreateFoos < ActiveRecord::Migration
  def change
    create_table :foos do |t|
      t.string :name
      t.boolean :public
      t.timestamps
    end
  end
end
