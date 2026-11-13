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

  after_create :create_website_types

  def create_website_types
    WebsiteType.find_or_create_by(name: 'Website', icon: 'globe')
    WebsiteType.find_or_create_by(name: 'Facebook', icon: 'facebook')
  end
end
