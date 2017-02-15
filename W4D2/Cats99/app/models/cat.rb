class Cat < ActiveRecord::Base

  validates :color, inclusion: { in: %w(orange black white brown
    calico gray), message: "%{ value } is not a valid color"}
  validates :sex, inclusion: { in: %w(M F), message: "%{ value } is not
    a valid sex"}
  validates :name, :color, :birth_date, :sex, presence: true

  def age
    Date.today.year - birth_date.year
  end

  has_many :cat_rental_requests, :dependent => :destroy

end


  # validates :size, inclusion: { in: %w(small medium large),
  #   message: "%{value} is not a valid size" }
