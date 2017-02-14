# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  email      :string           not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
  validates :name, :email, :user_id, presence: true
  validates :user_id, uniqueness: {scope: :email}

  belongs_to :owner

  has_many :contact_shares

  has_many :shared_users,
  through: :contact_shares,
  source: :user
end

#validates :user_name, :presence => true, :uniqueness => {:scope => :account_id}
