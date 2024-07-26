class AddPrivacyToMusic < ActiveRecord::Migration[7.1]
  def change
    add_column :musics, :privacy, :integer, default: 0, null: false
  end
end
