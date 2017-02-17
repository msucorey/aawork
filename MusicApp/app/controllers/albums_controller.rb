class AlbumsController < ApplicationController

  def index
    @albums = Album.all
    render :index
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = "invalid parameters"
      redirect_to new_band_album_url
    end
  end

  def new
    render :new
  end

  def edit

  end

  def show

  end

  def update

  end

  def destroy

  end

  def album_params
    params.require(:album).permit(:title, :band_id, :recorded)
  end

end
