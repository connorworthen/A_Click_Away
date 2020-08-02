class ProductsController < ApplicationController
    before_action :require_log_in, only: [:new, :create, :edit, :update]

    def new
        # nested
        if params[:manufacturer_id] && @manufacturer = Manufacturer.find_by(id: params[:manufacturer_id])
            @product = @manufacturer.products.build 
        else 
            @product = Product.new
            @product.build_manufacturer #create empty manufacturer
            @product.category.try(:id)

        end 
    end 

    def create
        product = Product.find_by(name: params[:product][:name],
            manufacturer_id: params[:product][:manufacturer_id])
        if product
            product.update(user_ids: current_user.id)
            redirect_to product_path(product)
        else 
            @product = Product.create(
                params.require(:product).permit(:name, :price, :category_id,
            :manufacturer_id, manufacturer_attributes: [:name])
            )
            if @product.save 
                @product.update(user_ids: current_user.id) 
                # binding.pry
                redirect_to product_path(@product)
            else 
                redirect_to new_product_path
            end 
        end 
    end 

    def show
        product_helper
        # @reviews = Review.most_recent(@product.id)
    end 

    def edit
        product_helper
    end 

    def update 
        product_helper
        @product.update(product_params)
        if @product.save 
            redirect_to product_path(@product )
        else 
            render :edit 
        end 
    end 

    private 

    def product_params
        params.require(:product).permit(:name, :price, :category,
        :body_part,
        mmanufacturer_attributes: [:id, :name]
        )
    end 

    def product_helper
        @product = Product.find_by(id: params[:id])
    end 

end