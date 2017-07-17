class DropMirrorPicrures < ActiveRecord::Migration[5.0]
  def change
   drop_table :mirror_pictures
 end
end
