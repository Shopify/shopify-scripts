# Set to the percentage discount you'd like to apply store-wide.
DISCOUNT_AMOUNT = 10
CUSTOMER_TAG = 'MEMBERSHIP'

if !Input.cart.customer.nil? and Input.cart.customer.tags.include?(CUSTOMER_TAG)
# Apply the discount to every item in the cart.
Input.cart.line_items.each do |line_item|
  line_item.change_line_price(line_item.line_price * (1.0 - (DISCOUNT_AMOUNT / 100.0)), message: "#{DISCOUNT_AMOUNT}% off store-wide!")
end
end

Output.cart = Input.cart
