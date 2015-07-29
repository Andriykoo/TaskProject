class Task < ActiveRecord::Base
  belongs_to :user
  has_many :share_tasks

  validates :user_id, presence: true
  validates :text, presence: true


  def get_email_person_share_task
    @user_share_id=self.share_tasks.select(:user_id).distinct
    if !@user_share_id.empty?
      @email= User.find_by(id:@user_share_id.first[:user_id]).email
    else
      return ""
    end
  end

end
