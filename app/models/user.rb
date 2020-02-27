class User < ApplicationRecord
  enum rank: {usual: 0,manager:1, admin:2}
  has_many :meals
  has_many :tables
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
