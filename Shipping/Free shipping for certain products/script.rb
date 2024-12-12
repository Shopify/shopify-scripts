FREE_TAG = 'freeship'

if Input.cart.shipping_address.country_code == 'US' && Input.cart.line_items.all?{|item| item.variant.product.tags.include? FREE_TAG}
  Input.shipping_rates.each do |shipping_rate|
    next if shipping_rate.price == Money.zero
    shipping_rate.apply_discount(shipping_rate.price, message: "Free Shipping!")
    break
  end
end

Output.shipping_rates = Input.shipping_rates
