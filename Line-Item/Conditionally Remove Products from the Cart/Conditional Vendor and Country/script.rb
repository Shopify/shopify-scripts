# ======================================= #
# Script code (do not modify) #
# ======================================= #

class RemoveLineItemsCampaign
  def initialize(vendors, countries)
    @vendors = vendors.map(&:downcase)
    @countries = countries.map(&:downcase)
  end

  def run(cart)
    return if cart.nil? || !@countries.include?(cart.shipping_address.country_code.downcase)
    cart.line_items.delete_if { |item| @vendors.include?(item.variant.product.vendor.downcase) }
  end
end

# ========================= #
# Settings - Modify #
# ========================= #

# # Set which vendors have restricted shipping countries
# # Products with this vendor will be automatically removed if
# # a restricted shipping address is selected during checkout:

# Campaign 1: Exclude from shipping to the EU
VENDOR_NOOP_EU = ['JordansAwesomeBrand', 'Example2']
NOOP_EU = ['AT', 'BE', 'BG', 'CY', 'CZ', 'DK', 'EE', 'FI', 'FR', 'DE', 'GR', 'HU', 'IE', 'IT', 'IM', 'HR', 'EL', 'LV', 'LT', 'LU', 'MT', 'NL', 'PL', 'PT', 'RO', 'SK', 'SI', 'ES', 'SE', 'GB']

# Campaign 2:  Exclude from shipping to the USA
VENDOR_NOOP_US = ['Example1', 'Example3', 'Example4']
NOOP_US = ['US']

# Campaign 3:  Exclude from shipping to Ocenia (Not including Hawaii because it uses the same ISO 3166-1 code as the USA)
VENDOR_NOOP_OCEANIA = ['JordansAwesomeBrand']
NOOP_OCEANIA = ['AU', 'NZ', 'NF', 'FJ', 'NC', 'PG', 'SB', 'VU', 'FM', 'GU', 'KI', 'MH', 'NR', 'MP', 'PW', 'UM', 'AS', 'CK', 'CL', 'PF', 'NU', 'PN', 'WS', 'TK', 'TO', 'TV', 'WF']

# Add each
CAMPAIGNS = [
RemoveLineItemsCampaign.new(VENDOR_NOOP_EU, NOOP_EU),
RemoveLineItemsCampaign.new(VENDOR_NOOP_US, NOOP_US),
RemoveLineItemsCampaign.new(VENDOR_NOOP_OCEANIA, NOOP_OCEANIA)
]

# ======================================= #
# Script code (do not modify) #
# ======================================= #

CAMPAIGNS.each do |campaign|
 campaign.run(Input.cart)
end

Output.cart = Input.cart
