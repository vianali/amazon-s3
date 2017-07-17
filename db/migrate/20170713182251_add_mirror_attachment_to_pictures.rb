class AddMirrorAttachmentToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :mirror_attachment, :string
  end
end
