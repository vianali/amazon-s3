class Picture < ApplicationRecord
	mount_uploader :attachment, AttachmentUploader
	mount_uploader :mirror_attachment, MirrorAttachmentUploader
end
