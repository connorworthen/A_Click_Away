class ProductsController < ApplicationController
    before_action :require_log_in, only: [:new, :create, :edit, :update]

    def index
        @products = Product.search(params[:search])
    end

    def show
        product_helper
    end

    def new
        @product = Product.new 
    end 
    
    def create
        @product = Product.create(product_params)
        if @product.save
            @product.update(user_ids: current_user.id)
            redirect_to product_path(@product)
        else
            render :new
        end
    end 

    def edit
        product_helper
    end 

    def update
        product_helper
        @product.update(product_params)
        if @product.save
            redirect_to product_path(@product)
        else 
            render :edit 
        end 
    end

    private 

    def product_params
        params.require(:product).permit(:name, :stock, :price, :bio, :search, manufacturer_attributes: [:id, :name])
    end 

    def product_helper
        @product = Product.find_by(params[:id])
    end

end