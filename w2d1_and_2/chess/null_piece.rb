require 'singleton'
class NullPiece < Piece
  include Singleton
  def self.instance
    @@instance ||= new
  end

  def moves
    nil
  end

  # def color
  #   nil
  # end
end
