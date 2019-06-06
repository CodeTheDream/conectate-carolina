class User < ApplicationRecord
  # you can also define enum as: enum role: [:user => 0, :vip => 2, etc.]
  # user.admin! # sets the role to "admin"
  # user.admin? # => true
  # user.role  # => "admin"
  # has_many :messages

  enum role: [:user, :vip, :admin]
  validates :role, inclusion: { in: roles.keys }

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
