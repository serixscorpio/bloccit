class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body, :post, :user

  default_scope order('created_at ASC')

  validates :body, length: { minimum: 5 }, presence: true
end
