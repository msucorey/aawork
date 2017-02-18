class PostSub < ActiveRecord::Base
  validates :post_id, :presence => true, :uniqueness => {:scope => :sub_id}
  validates :sub_id, presence: true, :uniqueness => {scope: :post_id}

  belongs_to :post

  belongs_to :sub
end
