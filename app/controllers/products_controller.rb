class ProductsController < ApplicationController
    before_action :correct_user, only: [:edit, :update, :destroy]

    def correct_user
        @manufacturer = Manufacturer.find_by(id: params[:id])
        return unless current_user
        flash[:alert] = "You are not allowed to access this part of the site"
        redirect_to root_path
    end

    def index
        product_helper
        @review = Review.find_by(params[:id])
        @reviews = Review.all
        @products = Product.all
    end

    def show
        product_helper
        @product = Product.all
    end

    def new
        @product = Product.new 
    end 
    
    def create
        @product = Product.create(product_params)
        if @product.save
            @product.update(user_ids: current_user.id)
            # redirect_to products_path(@product)
            redirect_to root_path
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
            redirect_to products_path(@product)
        else 
            render :edit 
        end 
    end

    def destroy
        product_helper
        @product.destroy
        redirect_to products_path
    end

    private 

    def product_params
        params.require(:product).permit(:name, :price, :stock, :description, :manufacturer_id, manufacturer_attributes: [:name])
    end 

    def product_helper
        @product = Product.find_by(params[:id])
    end

end