TAG = "VIP" #customer tag
MESSAGE = "Free Shipping For Princeton University Members" #additional message
customer = Input.cart.customer

if customer
 if customer.tags.include?(TAG)
   Input.shipping_rates.each do |shipping_rate|
     if shipping_rate.code.include?("INSERT_SHIPPING_CODE_HERE")
       shipping_rate.change_name("FREE GROUND SHIPPING (UPS Ground)", { message: "" })
       shipping_rate.apply_discount(shipping_rate.price, message: MESSAGE)
     end
   end
 end
end

Output.shipping_rates = Input.shipping_rates
