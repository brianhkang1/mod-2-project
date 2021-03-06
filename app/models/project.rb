class Project < ApplicationRecord
  has_many :project_backings, :foreign_key => :backed_project_id
  has_many :backers, through: :project_backings, :source => :project_backer
  belongs_to :creator, :class_name => "User"
  belongs_to :category
  mount_uploader :project_photo, ProjectPhotoUploader

  ###validations
  validates :title, presence: true
  validates :description, presence: true, length: {minimum: 30}
  validates :funds_needed, presence: true

  def number_of_supporters
    self.backers.uniq.count
  end

  def lowercase_title
    self.title.downcase
  end

  def self.search(q)
    if q
      where('title LIKE ?', "%#{q}%")
    else
      all
    end
  end

end
