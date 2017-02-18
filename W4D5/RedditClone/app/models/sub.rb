class Sub < ActiveRecord::Base
  validates :title, :user_id, presence: true

  belongs_to :moderator,
    foreign_key: :user_id,
    class_name: :User

  has_many :original_posts,
    class_name: :Posts

  has_many :posts,
    through: :post_subs,
    source: :post

  has_many :post_subs
end
