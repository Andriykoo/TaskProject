class Task < ActiveRecord::Base
  belongs_to :user
  has_many :share_tasks

  validates :user_id, presence: true
  validates :text, presence: true

end
