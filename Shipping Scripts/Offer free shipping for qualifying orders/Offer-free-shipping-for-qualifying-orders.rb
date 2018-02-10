MINIMUM_ORDER_AMOUNT = 3000 #dollars required in cart to get discount
MESSAGE = "Minimum Order $30 Promotion" #promotional message

if Input.cart.shipping_address.country_code == 'US' && Input.cart.subtotal_price_was > Money.new(cents: MINIMUM_ORDER_AMOUNT)
  Input.shipping_rates.each do |shipping_rate|
    next if shipping_rate.name.include? ("Priority Mail")
    shipping_rate.change_name("You get Free Shipping!", { message: "" })
    shipping_rate.apply_discount(shipping_rate.price, message: MESSAGE)
  end
end

Output.shipping_rates = Input.shipping_rates
