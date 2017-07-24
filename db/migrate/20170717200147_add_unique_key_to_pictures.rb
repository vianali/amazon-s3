class AddUniqueKeyToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :unique_key, :string
  end
end
