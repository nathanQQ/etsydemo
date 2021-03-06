class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy, :edit, :seller]
  before_filter :check_user, only: [:edit, :update, :destroy]

  # GET /listings
  # GET /listings.json

# all_listings is not the homepage!!!
  def all_listings
    @listings = Listing.all
    #@listings = Listing.order("created_at DESC").page(params[:page])
    #@listings = Kaminari.paginate_array(Listing.first(4)).page(params[:page])
    #@listings = Listing.paginate(:page => params[:page], :per_page => 8)
  end

  def seller
    @listings = Listing.where(user: current_user).order("created_at DESC")
  end

  def index
    #@listings = Listing.all.order("created_at DESC")
    @listings = Listing.order("created_at DESC").page(params[:page])
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)

    @listing.user_id = current_user.id;
    @listing.created_date = Date.today;

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :description, :price, :image)
    end

    # Wenqian: cannot output alter msg, but check_user is functional
    def check_user
      if current_user != @listing.user
        redirect_to root_url, alter: "cannot modify listing belong to others!"
      end
    end   

end
