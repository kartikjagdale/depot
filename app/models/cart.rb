=begin
	Remember we added "belongs_to" to line_item.rb,
	Hence to be ableto traverse these relationships in both directions, we need to add
	some declarations to our model files that specify their inverese relations.

	Secondly "dependent: :destroy", if cart destroyed we want rails to destroy line item
	assocaited with that cart too.
		_VoidZero

	"find_by" method returns an existing line_item or nil
=end


class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy

	def add_product(product_id)
		current_item = line_items.find_by(product_id: product_id)
		if current_item
			current_item.quantity +=1
		else
			current_item = line_items.build(product_id: product_id)
		end
			current_item
	end
end
