# frozen_string_literal: true

class CreateNewsarticles < ActiveRecord::Migration[7.0]
  def change
    create_table :newsarticles do |t|
      t.string :source
      t.string :author
      t.string :title
      t.string :text
      t.string :imglink
      t.string :articlelink

      t.timestamps
    end
  end
end
