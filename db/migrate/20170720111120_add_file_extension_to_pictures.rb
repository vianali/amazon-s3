class AddFileExtensionToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :file_extension, :string
  end
end
