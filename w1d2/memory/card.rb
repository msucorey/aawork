class Card
  attr_accessor :face_value, :face_down

  def initialize ()
    @face_down = true

  end

  def face_down?
    face_down
  end

end
