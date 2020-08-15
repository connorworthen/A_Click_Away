class ManufacturersController < ApplicationController
    
    def index
        manufacturer_helper
        @manufacturers = Manufacturer.all
    end
    
    def show
        manufacturer_helper
        @manufacturer = Manufacturer.all
        # @products = Product.alphabetize(@manufacturer.id)
    end
    
    def new
        @manufacturer = Manufacturer.new
    end

    def create
        @manufacturer = Manufacturer.create(manufacturer_params)
        if @manufacturer.save
            @manufacturer.id = current_user.id
            # redirect_to manufacturers_path(@manufacturer)
            redirect_to root_path
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

    def destroy
        manufacturer_helper
        @manufacturer.destroy
        redirect_to manufacturers_path
    end

    private 

    def manufacturer_params
        params.require(:manufacturer).permit(:name, :bio, :established)
    end

    def manufacturer_helper
        @manufacturer = Manufacturer.find_by(params[:id])
    end

end

