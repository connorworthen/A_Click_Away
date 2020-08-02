class ManufacturersController < ApplicationController

    def index 
        @manufacturers = Manufacturer.search(params[:search])
    end

    def show
        @manufacturer = Manufacturer.find_by(id: params[:id])
        @products = Product.alphabetize(@manufacturer.id)
    end 
    
end