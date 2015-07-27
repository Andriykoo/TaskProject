class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tasks, dependent: :destroy
  has_many :share_tasks, dependent: :destroy

  validates :name, absence: false


  after_create do
    self.add_role :user
  end

end
