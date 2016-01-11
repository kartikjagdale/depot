=begin

"belongs_to" tells rails that rows in LineItem table are children of 
rows in carts and products tables.
	_VoidZero
=end

class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  belongs_to :cart
  def total_price
  	product.price * quantity
  end
end
