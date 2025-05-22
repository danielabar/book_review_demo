class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable, :registerable
end
