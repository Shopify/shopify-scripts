# Stop customers from using a discount code
# This script will reject all discount codes. Useful if you have a sale
# and don't want additional discounts to be applied

# Set the rejection message for discount codes
REJECTION_MESSAGE = "Discount codes cannot be used during this sale"

class RejectAllDiscountCodes
  # Initializes the campaign.
  #
  # Arguments
  # ---------
  # * rejection_message
  #   A message to display to the customer giving the reason the code was rejected

  #
  def initialize(rejection_message)
    @rejection_message = rejection_message
  end
  
  # Runs the campaign on the given cart.
  #
  # Arguments
  # ---------
  # * cart
  #   The cart to which the campaign is applied.
  #
  # Example
  # -------
  # To run the campaign on the input cart:
  #
  #   RejectAllDiscountCodes.run(Input.cart)
  #
  def run(cart)
    # Exit if there is no discount code applied
    return unless cart.discount_code
    
    # Reject the discount code with the message
    cart.discount_code.reject({message: @rejection_message})
  end
end

# Array of campaigns to be run on the cart.
CAMPAIGNS = [
  # Initialize the campaigns with the required inputs
  RejectAllDiscountCodes.new(
    REJECTION_MESSAGE  
  )  
]

# Iterate through each of the discount campaigns.
CAMPAIGNS.each do |campaign|
  # Apply the campaign onto the cart.
  campaign.run(Input.cart)
end

Output.cart = Input.cart