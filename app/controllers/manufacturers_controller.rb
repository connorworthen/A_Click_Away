class ManufacturersController < ApplicationController
    
    def show
        manufacturer_helper
        # @products = Product.alphabetize(@manufacturer.id)
    end
    
    def new
        @manufacturer = Manufacturer.new
    end

    def create
        @manufacturer = Manufacturer.create(manufacturer_params)
        if @manufacturer.save
            @manufacturer.update(user_ids: current_user.id)
            redirect_to manufacturers_path(@manufacturer)
        else
            render :new
        end
    end

    def edit
        manufacturer_helper
    end 

    def update
        manufacturer_helper
        @manufacturer.update(manufacturer_params)
        if @manufacturer.save
            redirect_to manufacturers_path(@manufacturer)
        else 
            render :edit 
        end 
    end

    private 

    def manufacturer_params
        params.require(:manufacturer).permit(:name, :bio, :established)
    end

    def manufacturer_helper
        @manufacturer = Manufacturer.find(params[:id])
    end

end

