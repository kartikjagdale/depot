=begin
		Defination "set_cart" is a private method which starts by getting :cart_id from the sesion object
		and then attempts to find the existing cart to this ID. if cart is not found then the 
		rescue method comes in picture which creates a new Cart, stores the ID in the session and 
		then return the new Cart.
			_VoidZero
=end

module CurrentCart
	extend ActiveSupport::Concern
	private
		def set_cart
		@cart = Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound
		@cart = Cart.create
		session[:cart_id]= @cart.id
	end

end