# This shipping script is a bit esoteric, but it's useful for high-volume stores
# where even a few minutes of downtime on the part of a third party shipping
# calcluation app could result in lost sales.
#
# This script assumes that you're using one or more third party carrier APIs for
# fetching shipping rates (CARRIER_SOURCES), and that you've also set up some
# "fallback" rates in Shopify as a backup. If any carrier rates are present, this
# script will hide the fallback Shopify rates. If they're not (eg because the third
# party is down or times out), the fallback rates remain.

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
