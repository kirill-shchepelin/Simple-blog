class AttachmentFile < Asset

  has_attached_file :data,
                    :url => "/system/ckeditor/attachments/:id/:filename",
                    :path => ":rails_root/public/system/ckeditor/attachments/:id/:filename"

  validates_attachment_size :data, :less_than=>10.megabytes
end

