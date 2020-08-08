class ManufacturersController < ApplicationController
    
    def index 
        @manufacturers = Manufacturer.search(params[:search])
    end

    def show
        @manufacturer = Manufacturer.find_by(id: params[:id])
        @products = Product.alphabetize(@manufacturer.id)
    end
    
    def new
        @manufacturer = Manufacturer.new
    end

    def create
        @manufacturer = Manufacturer.create(manufacturer_params)
        if @manufacturer.save
            @manufacturer.update(user_ids: current_user.id)
            redirect_to manufacturer_path
        else
            render :new
        end
    end

    private 

    def manufacturer_params
        params.require(:manufacturer).permit(:name, :bio, :established)
    end

end

