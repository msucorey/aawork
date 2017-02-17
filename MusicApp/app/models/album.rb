# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recorded   :string
#  band_id    :integer
#

class Album < ActiveRecord::Base

  belongs_to :band
  has_many :tracks, dependent: :destroy

end
