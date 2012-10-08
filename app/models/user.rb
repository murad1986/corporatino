class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :recoverable, :validatable,  :encryptable, :registerable,:confirmable, :lockable, :timeoutable and :omniauthable
  has_many :corporations, :dependent => :destroy

  devise :database_authenticatable, :registerable,
          :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :password, :password_confirmation, :remember_me
  has_many :abonent_tarifs, :dependent => :destroy
end
