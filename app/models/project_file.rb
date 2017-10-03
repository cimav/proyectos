#encoding: utf-8

class ProjectFile < ApplicationRecord
  belongs_to :project_folder
  belongs_to :user
  mount_uploader :file, DocumentUploader

  def full_path
    "#{Rails.root}/public#{self.file.to_s}"
  end

  def size
  	if File.exists?(full_path)
      File.size(full_path)
    else
      0
    end
  end

  def ext
    ext = File.extname(self.file.to_s).to_s.downcase
    ext[0] = ''
    ext
  end
end
