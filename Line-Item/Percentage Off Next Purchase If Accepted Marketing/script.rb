# Define the discount for eligible customers.
DISCOUNT_AMOUNT = 10

# Checks to see if this is a customer's second order, and that they opted into marketing the first time around.
if (!Input.cart.customer.nil? && Input.cart.customer.orders_count == 1 && Input.cart.customer.accepts_marketing?)
  Input.cart.line_items.each do |line_item|
    line_item.change_line_price(line_item.line_price * (1.0 - (DISCOUNT_AMOUNT / 100.0)), message: "#{DISCOUNT_AMOUNT}% off for subscribing to our newsletter!")
  end  
end

Output.cart = Input.cart
