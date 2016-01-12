require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

 #loading Data
fixtures :products
test "buying a product" do
 
  #emptying the cart, line_item and Order
  LineItem.delete_all
  Order.delete_all
  ruby_book = products(:ruby)

  #A user goes to store
  get "/"
  assert_response :success
  assert_template "index"

  #Select a Product and  add it to cart and check if right product is added
  xml_http_request :post, '/line_items', product_id: ruby_book.id
  assert_response :success

  cart = Cart.find(session[:cart_id])
  assert_equal 1, cart.line_items.size
  assert_equal ruby_book, cart.line_items[0].product

  #User Checking out
  get "/orders/new"
  assert_response :success
  assert_template "new"

  #User sumbitted data and order is successfull and 
  #now he/she is redirected to main page of side
  #also we check wheter the cart is empty or not 
  post_via_redirect "/orders",
  		order: {name: "Dave Thomas",
  			address: "123 The Street",
  			email: "dave@example.com",
  			pay_type: "Check"
  		}
  assert_response :success
  assert_template "index"
  cart = Cart.find(session[:cart_id])
  assert_equal 0, cart.line_items.size

  
  #Check in database if the order is successfully added or not
  orders = Order.all
  assert_equal 1, orders.size
  order = orders[0]

  assert_equal "Dave Thomas", order.name
  assert_equal "123 The Street", order.address
  assert_equal "dave@example.com", order.email
  assert_equal "Check", order.pay_type

  assert_equal 1, order.line_items.size
  line_item = order.line_items[0]
  assert_equal ruby_book, line_item.product

  #Check if the mails details send are right or not
  mail = ActionMailer::Base.deliveries.last
  assert_equal ["dave@example.com"], mail.to
  assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
  assert_equal "Pragmatic Store Order Confirmation", mail.subject
end

end
