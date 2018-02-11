# Define the ID of the free product.
FREE_GIFT_PRODUCT_ID = 9307791812

# Check that we have at least two items in the cart (so that there's a "purchase").
if Input.cart.line_items.size > 1
  Input.cart.line_items.each do |line_item|
    # If the free gift is found, set its price to zero.
    if line_item.variant.product.id == FREE_GIFT_PRODUCT_ID
      if line_item.quantity > 1
        line_item = line_item.split(take: 1)
        Input.cart.line_items << line_item
      end
      line_item.change_line_price(Money.zero, message: "Free gift with purchase!")
    end  
  end  
end

# Export the cart.
Output.cart = Input.cart
