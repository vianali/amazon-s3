require 'uri'
class Picture < ApplicationRecord

	mount_uploader :attachment, AttachmentUploader
	mount_uploader :mirror_attachment, MirrorAttachmentUploader

	after_validation :set_unique_key
	after_validation :update_attachment_attributes
	after_validation :update_attachment_extension

	  private

	  def set_unique_key
	    self.unique_key = generate_unique_key
	  end

	  def generate_unique_key
	    loop do
	      unique_key = SecureRandom.hex(10)
	      break unique_key unless Picture.where(unique_key: unique_key).exists?
	    end
	  end

	  def update_attachment_attributes
	    if attachment.present? && attachment_changed?
	      self.file_size = format_mb(attachment.file.size)
	    end
	  end



      def format_mb(size)
		  conv = [ 'b', 'kb', 'mb', 'gb', 'tb', 'pb', 'eb' ];
		  scale = 1024;

		  ndx=1
		  if( size < 2*(scale**ndx)  ) then
		    return "#{(size)} #{conv[ndx-1]}"
		  end
		  size=size.to_f
		  [2,3,4,5,6,7].each do |ndx|
		    if( size < 2*(scale**ndx)  ) then
		      return "#{'%.3f' % (size/(scale**(ndx-1)))} #{conv[ndx-1]}"
		    end
		  end
		  ndx=7
		  return "#{'%.3f' % (size/(scale**(ndx-1)))} #{conv[ndx-1]}"
	  end


	  def update_attachment_extension
	      if attachment.present? && attachment_changed?
	      self.file_extension = File.extname(self.attachment.url).split(".").last
	    end
	  end 




end
