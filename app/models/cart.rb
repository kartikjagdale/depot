=begin
	Remember we added "belongs_to" to line_item.rb,
	Hence to be ableto traverse these relationships in both directions, we need to add
	some declarations to our model files that specify their inverese relations.

	Secondly "dependent: :destroy", if cart destroyed we want rails to destroy line item
	assocaited with that cart too.
		_VoidZero
=end


class Cart < ActiveRecord::Base
	has_many :line_items, dependent: :destroy
end
