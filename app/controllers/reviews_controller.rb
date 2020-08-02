class ReviewsController < ApplicationController
    before_action :require_log_in
    before_action :edit_review, only: [:edit, :update]

    def new
        params[:product_id] && @product = Product.find_by_id(params[:product_id])
        @product.reviews.build
        @review = Review.new
    end 

    def create 

        params[:product_id] && @product = Product.find_by_id(params[:product_id])
        @review = Review.create(review_params)

        if @review.save 
            redirect_to product_path(@review.product_id)
        else 
            render :new
        end 
    end 

    def show
        @product = Product.find_by(id: params[:product_id])
        @review = Review.find_by(id: params[:id])

    end 

    def edit
        @product = Product.find_by(id: params[:id])
        @review = Review.find_by(product_id: params[:id])
    end 

    def update
        @product = Product.find_by_id(params[:product_id])
        @review = Review.find_by_id(params[:id])
        @review.update(review_params)
        if @review.save
            redirect_to product_path(@review.product_id)
        else 
            render :edit 
        end 
    end 

    def destroy
        @review = Review.find_by_id(params[:id])
        @product = Product.find_by(id: @review.product_id)
        @review.destroy
        redirect_to product_path(@product)
    end 

    private

    def review_params
        params.require(:review).permit(
            :product_id, :rating, :comment, :user_id 
            )
    end 

    def edit_review
        @review = Review.find_by_id(params[:id])
        if @review.user_id != current_user.id 
            redirect_to product_path(@review.product_id)
        end 
    end 


end