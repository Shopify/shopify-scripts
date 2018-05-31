# Define the name of the pick up shipping rate - this should be added manually in the Shopify Admin.
PICKUP_SHIPPING_RATE_NAME = 'Pick Up In-Store'

# Define a list of postcode prefixes that are allowed to pick up from the store.
PICKUP_POSTCODE_PREFIXES = [
  '100', '101', '102'
]  

# Output filtered shipping rates.
Output.shipping_rates = Input.shipping_rates.delete_if do |shipping_rate|
  (shipping_rate.name == PICKUP_SHIPPING_RATE_NAME) && !PICKUP_POSTCODE_PREFIXES.any? { |prefix| Input.cart.shipping_address.zip.start_with?(prefix) }
end
