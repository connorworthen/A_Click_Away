class SearchController < ApplicationController

  def search  
    if params[:search].blank?
      redirect_to root_path, notice: "Empty field!"
    else
      @parameter = params[:search].downcase
      @product = Product.find_by(params[:id])
      @products = Product.all 
    end  
  end

end