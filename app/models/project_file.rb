class ProjectFile < ApplicationRecord
  belongs_to :project_folder
  belongs_to :user

  def size
  	"0 KB"
  end

  def ext
    "XLS" 
  end
end
