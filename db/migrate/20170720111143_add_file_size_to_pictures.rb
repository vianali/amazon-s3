class AddFileSizeToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :file_size, :string
  end
end
