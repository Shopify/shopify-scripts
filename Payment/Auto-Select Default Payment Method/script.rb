# Define the preferred order of gateways.
PREFERRED_GATEWAY_ORDER = ['Invoice', 'Shopify Payments']

# Sort gateways.
Output.payment_gateways = Input.payment_gateways.sort_by do |payment_gateway|
  PREFERRED_GATEWAY_ORDER.index(payment_gateway.name) || 999
end
