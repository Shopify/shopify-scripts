DISCOUNT_AMOUNT = 15

if (Input.cart.line_items.size > 1)
  line_item = Input.cart.line_items.sort_by { |line_item| line_item.variant.price }.first
  if line_item.quantity > 1
    line_item = line_item.split(take: 1)
    Input.cart.line_items << line_item
  end
  line_item.change_line_price(line_item.line_price * (1.0 - (DISCOUNT_AMOUNT / 100.0)), message: "#{DISCOUNT_AMOUNT}% off!")
end

Output.cart = Input.cart
