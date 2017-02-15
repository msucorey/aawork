class CatRentalRequestsController < ApplicationController

  def index
    @catrentalrequests = CatRentalRequest.all
    render :index
  end

  def show
    @catrentalrequest = CatRentalRequest.find_by(id: params[:id])
    render :show
  end

  def new
    @catrentalrequest = CatRentalRequest.new
    render :new
  end

  def create
    @catrentalrequest = CatRentalRequest.new(cat_rental_request_params)
    # fail
    if @catrentalrequest.save
      redirect_to cat_rental_request_url(@catrentalrequest)
    else
      render :new
    end
  end

  def approve
    @catrentalrequest = CatRentalRequest.find_by(id: params[:id])
    @catrentalrequest.approve!
    redirect_to cat_url(@catrentalrequest)
  end

  def deny
    @catrentalrequest = CatRentalRequest.find_by(id: params[:id])
    @catrentalrequest.deny!
    tempcat = Cat.find_by(@cat_rental_requests.cat_id)
    puts tempcat
    puts cat_id
    redirect_to cat_url(tempcat)
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
