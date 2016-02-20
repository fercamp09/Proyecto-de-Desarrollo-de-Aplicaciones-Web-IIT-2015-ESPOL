class Diagram < ActiveRecord::Base
  has_many :diagrams_users, dependent: :delete_all
  has_many :users, through: :diagrams_users
  has_many :entities, dependent: :destroy
  has_many :relations, dependent: :destroy
end
