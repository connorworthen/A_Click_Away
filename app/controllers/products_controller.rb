class ProductsController < ApplicationController
    before_action :require_log_in, only: [:new, :create, :edit, :update]

    def index
        # if params[:user_id]
        #     @user = User.find(params[:user_id])
        #     @products = @user.products.all
        # else
            @products = Product.all
        # end
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

    private 

    def product_params
        params.require(:product).permit(:name, :price, :stock, :description, :manufacturer_id, manufacturer_attributes: [:name])
    end 

    def product_helper
        @product = Product.find_by(params[:id])
    end

end