class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # Associations
  has_one :user, dependent: :destroy
  
  # Callbacks
  after_create :create_user_profile
  
  private
  
  def create_user_profile
    User.create!(
      account: self,
      username: email.split('@').first,
      email: email,
      timezone: 'UTC'
    )
  end
end
