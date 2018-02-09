# Set to the percentage discount you'd like to apply store-wide.
DISCOUNT_AMOUNT = 10

# Apply the discount to every item in the cart.
Input.cart.line_items.each do |line_item|
  line_item.change_line_price(line_item.line_price * (1.0 - (DISCOUNT_AMOUNT / 100.0)), message: "#{DISCOUNT_AMOUNT}% off store-wide!")
end

Output.cart = Input.cart
