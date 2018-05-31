# Name of the invoice payment method.
INVOICE_GATEWAY_NAME = 'Invoice'

# Tag that wholesale customers are expected to have.
WHOLESALE_CUSTOMER_TAG = 'Wholesale'

##
# Filter out the invoice payment gateway if the customer is so tagged.
Output.payment_gateways = Input.payment_gateways.delete_if do |payment_gateway|
  case payment_gateway.name
    when INVOICE_GATEWAY_NAME
      Input.cart.customer.nil? || !Input.cart.customer.tags.include?(WHOLESALE_CUSTOMER_TAG)
    else
      false
  end
end
