class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable, :validatable


end
