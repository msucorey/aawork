class Comment < ActiveRecord::Base

  validates :content, :post_id, :user_id, presence: true
end
