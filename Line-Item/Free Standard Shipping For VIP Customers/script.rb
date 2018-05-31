# Define a list of shipping service names that are eligible for free shipping for VIPs.
ELIGIBLE_SERVICES = ['Standard Ground Shipping']

# Define the tag that identifies VIP customers.
VIP_CUSTOMER_TAG = 'VIP'

# If the customer is a VIP, give them free shipping on the defined services.
if !Input.cart.customer.nil? and Input.cart.customer.tags.include?(VIP_CUSTOMER_TAG)
  Input.shipping_rates.each do |shipping_rate|
    if ELIGIBLE_SERVICES.include?(shipping_rate.name)
      shipping_rate.apply_discount(shipping_rate.price, message: "Free shipping for VIP customers!")
    end  
  end  
end 

# Export the rates.
Output.shipping_rates = Input.shipping_rates
