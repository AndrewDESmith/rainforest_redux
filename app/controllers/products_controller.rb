class ProductsController < ApplicationController
  def index
  	@products = Product.all
  end

  def show
  	@product = Product.find(params[:id])
  end

  def new
  	@product = Product.new
  	# Where happens after a new product is instantiated?
  end

  def edit
  	@product = Product.find(params[:id])

  	if @product
  		render :edit
  	else
  		flash("This product id does not exist!")
  	end
  end

  def create
  	@product = Product.new(product_params)
  	#  Why are new and create separate actions?  I assume create is called somewhere else to grab a newly created product.
  	if @product.save
  		redirect_to products_url
  		# Why not render :index?
      # Render, unlike redirect, does not create a new request.  It's the response to the current request (even though it's a new page).
  	else
  		render :new
  		# render keeps the current information stored within some parameters, and redisplays upon a failed validation.  redirect_to does NOT.  
  		# Why isn't the syntax render "new"?  You can!!
  	end
  end

  def update
  	@product = Product.find(params[:id])

  	if @product.update_attributes(product_params)
  		redirect_to product_path(@product)
  		# Why not use render :show, since it is specific to product id?  Check.
  	else
  		render :edit
  	end
  end

  def destroy
  	@product = Product.find(params[:id])
  	@product.destroy
  	# Isn't calling.destroy within the destroy method an infinite loop?  Shouldn't it be a separately named method such as .delete?  Or does Rails just "know" in this context that calling .destroy refers to another method with the same name?
    # ANSWER  .destroy is a distinct method within the ActiveRcord Class, which is inherited by the Product Model (which is why you can call it on an instance of Product).
  	redirect_to products_path
  end

  private
  def product_params
  	params.require(:product).permit(:name, :description, :price_in_cents)
  end
end





# class Dog
#   def eat
#     puts "dog is eating"
#   end
# end

# class Cat
#   def eat
#     puts "cat is eating"
#   end
# end

# dog = Dog.new
# cat = Cat.new

# def eat(dog, cat)
#   dog.eat
#   cat.eat
# end

# eat(dog, cat)