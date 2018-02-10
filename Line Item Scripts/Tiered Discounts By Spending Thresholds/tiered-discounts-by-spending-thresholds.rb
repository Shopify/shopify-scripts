# Define spending thresholds, from lowest spend to highest spend.
SPENDING_THRESHOLDS = [
  {
    spend: 3000,   # spend amount (in cents)
    discount: 10   # percentage discount
  },
  {
    spend: 5000,
    discount: 15
  },
  {
    spend: 10000,
    discount: 20
  }  
]

# Find any applicable spending threshold.
eligible_threshold = nil
SPENDING_THRESHOLDS.each do |threshold|
  if Input.cart.subtotal_price_was.cents >= threshold[:spend]
    eligible_threshold = threshold
  end  
end

# Apply threshold.
if !eligible_threshold.nil?
  Input.cart.line_items.each do |line_item|
    line_item.change_line_price(line_item.line_price * (1.0 - (eligible_threshold[:discount] / 100.0)), message: "#{eligible_threshold[:discount]}% off for purchases over $#{eligible_threshold[:spend] / 100}!")
  end
end

Output.cart = Input.cart
