# frozen_string_literal: true

class AddUserIdToNewsarticles < ActiveRecord::Migration[7.0]
  def change
    add_column :newsarticles, :user_id, :integer
    add_index :newsarticles, :user_id
  end
end
