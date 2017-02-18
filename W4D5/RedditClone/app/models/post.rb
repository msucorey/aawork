class Post < ActiveRecord::Base
  validates :author, :title, presence: true
  validate :at_least_one_sub

  belongs_to :author,
    foreign_key: :user_id,
    class_name: :User

  has_many :post_subs

  has_many :subs,
  through: :post_subs,
  source: :sub

  has_many :comments, dependent: :destroy

  def at_least_one_sub
    return if subs.size > 0
    self.errors[:no] << "subs associated with this post"
  end

end
