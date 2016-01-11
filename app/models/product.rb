#Author : VoidZero
=begin
	"has_many" A product has many line items(inverese relations)
	"before_destroy" a hook method, that is before calling a destructor on this
		object it checks if no line item is refrenced by the onject.
		if yes return error if not row gets deleted.
=end

class Product < ActiveRecord::Base
	
	has_many :line_items
	has_many :orders, through: :line_items
	before_destroy :ensure_not_referenced_by_any_line_item

	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, uniqueness: true
	validates :image_url, allow_blank: true, format:{
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a url for GIF, JPG or PNG image.'	
	}
	def self.latest
		Product.order(:updated_at).last
	end

	# ensure that there are no line items refrencing this product
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line Items present')
			return false
	end
end

end
