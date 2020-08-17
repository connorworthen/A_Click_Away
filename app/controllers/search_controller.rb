class SearchController < ApplicationController

  def search  
    if params[:search].blank?  
      redirect_to(root_path, alert: "Empty field!") and return  
    else
      @parameter = params[:search].downcase 
      @product = Product.find_by(params[:id])
      @products = Product.all 
      @product = Product.all.where("lower(name) LIKE :search", search: "%#(@parameter)#%")  
    end  
  end

end