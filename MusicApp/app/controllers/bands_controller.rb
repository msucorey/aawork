class BandsController < ApplicationController

  def index
    @bands = Band.all
    render :index
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to bands_url, action: :get
    else 
      redirect_to bands_url, action: :get
    end
  end

  def new
    render :new
  end

  def edit
    @band = Band.find_by(id: params[:id])
    render :edit
  end

  def show
    @band = Band.find_by(id: params[:id])
    render :show
  end

  def update
    @band = Band.find_by(id: params[:id])
    @band.update_attributes(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash[:errors] = "update failed"
      redirect_to band_url(@band)
    end
  end

  def destroy
    @band = Band.find_by(id: params[:id])
    @band.destroy
    redirect_to bands_url
  end

  def band_params
    params.require(:band).permit(:name)
  end

end

# bands GET    /bands(.:format)                       bands#index
#       POST   /bands(.:format)                       bands#create
# new_band GET    /bands/new(.:format)                   bands#new
# edit_band GET    /bands/:id/edit(.:format)              bands#edit
#  band GET    /bands/:id(.:format)                   bands#show
#       PATCH  /bands/:id(.:format)                   bands#update
#       PUT    /bands/:id(.:format)                   bands#update
#       DELETE /bands/:id(.:format)                   bands#destroy
