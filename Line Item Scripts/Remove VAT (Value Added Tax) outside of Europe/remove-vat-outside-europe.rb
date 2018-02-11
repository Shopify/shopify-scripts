# Remove Value-Added Tax (VAT) outside of Europe
# This script will remove VAT when the destination country is not in Europe
# To be used only when the tax is included in the price of the items

# Set the VAT percentage included in product price
VAT_PERCENT = 20

# Message that will be shown to customers on the cart page
# Some themes will require code changes to support this
VAT_REMOVAL_MESSAGE = "VAT removed"

# List of country codes (two digits) that VAT applies to. Separate with a space.
COUNTRY_CODES = %w(
  AT BE BG CY CZ DK EE FI FR DE GR HU IE IT
  LV LT LU MT NL PL PT RO SK SI ES SE GB
)

class RemoveVATWhenNotApplicable
  # Initializes the campaign
  #
  # Arguments
  # ---------
  # * vat_percent
  #   The percent of VAT included in the price of the products
  #
  # * country_codes
  #   The country codes that VAT does apply
  #
  # * message
  #   A message to display to the customer when VAT is removed
  #
  def initialize(vat_percent, country_codes, message)
    @vat_percent = vat_percent
    @country_codes = country_codes
    @message = message
  end
  
  # Removes VAT from a line item in the cart
  #
  # Arguments
  # ---------
  # * line_item
  #   The line item to which the discount is applied
  #
  def remove_vat(line_item)
    calculated_tax_fraction = @vat_percent / (100 + @vat_percent)
    item_tax = line_item.variant.price * calculated_tax_fraction
    per_item_price = line_item.variant.price - item_tax
    new_line_price = per_item_price * line_item.quantity
    line_item.change_line_price(new_line_price, message: @message)
  end
  
  # Runs the campaign on the given cart.
  #
  # Arguments
  # ---------
  # * cart
  #   The cart to which the campaign is applied
  #
  # Example
  # -------
  # To run the campaign on the input cart:
  #
  #   RemoveVATWhenNotApplicable.run(Input.cart)
  #
  def run(cart)
    # Exit if there is no shipping address or country code available
    return unless cart.shipping_address&.country_code
    
    # Exit if the shipping address is in the countries that it applies
    ship_to = cart.shipping_address.country_code
    return if @country_codes.include?(ship_to)
    
    # Remove the VAT from each item in the cart
    cart.line_items.each do |line_item|
      # Skip any gift cards
      next if line_item.variant.product.gift_card?
      remove_vat(line_item)
    end
  end
  
end

# Array of campaigns to be run on the cart
CAMPAIGNS = [
  # Initialize the campaign with the required inputs
  RemoveVATWhenNotApplicable.new(
    VAT_PERCENT,
    COUNTRY_CODES,
    VAT_REMOVAL_MESSAGE
  )
]

# Iterate through each of the discount campaigns
CAMPAIGNS.each do |campaign|
  # Apply the campaign onto the cart
  campaign.run(Input.cart)
end

Output.cart = Input.cart