CARRIER_SOURCES = ['custom_app']

carrier_rates_present = Input.shipping_rates.any? { |shipping_rate| CARRIER_SOURCES.include?(shipping_rate.source) }

# Filter rates as needed.
filtered_shipping_rates = []
Input.shipping_rates.each do |shipping_rate|
  if carrier_rates_present && (shipping_rate.source == 'shopify') 
    # Don't include the rate.
  else
    filtered_shipping_rates << shipping_rate
  end
end

# Export the rates.
Output.shipping_rates = filtered_shipping_rates
