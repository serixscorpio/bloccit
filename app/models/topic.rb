class Topic < ActiveRecord::Base
  attr_accessible :description, :name, :public
  has_many :posts

  validates :name, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 10 }, presence: true
end
