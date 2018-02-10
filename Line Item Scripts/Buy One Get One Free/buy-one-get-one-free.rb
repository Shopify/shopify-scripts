# Buy One, Get One Free Script
# The basis of this script provided by the Script Editor itself as a "default" script option.

# Adjusting these values lets you tweak the scope of the discount, eg:
# PAID_ITEM_COUNT = 1, DISCOUNTED_ITEM_COUNT = 1 -> Buy One, Get One
# PAID_ITEM_COUNT = 3, DISCOUNTED_ITEM_COUNT = 2 -> Buy Three, Get Two
PAID_ITEM_COUNT = 1
DISCOUNTED_ITEM_COUNT = 1

# Specify the IDs of the products you'd like to be eligible for this promotion.
ELIGIBLE_PRODUCT_IDS = [9307791812, 9307791940]

# Returns the integer amount of items that must be discounted next
# given the amount of items seen
#
def discounted_items_to_find(total_items_seen, discounted_items_seen)
  Integer(total_items_seen / (PAID_ITEM_COUNT + DISCOUNTED_ITEM_COUNT) * DISCOUNTED_ITEM_COUNT) - discounted_items_seen
end

# Partitions the items and returns the items that are to be discounted.
#
# Arguments
# ---------
#
# * cart
#   The cart to which split items will be added (typically Input.cart).
#
# * line_items
#   The selected items that are applicable for the campaign.
#
def partition(cart, line_items)
  # Sort the items by price from high to low
  sorted_items = line_items.sort_by{|line_item| line_item.variant.price}.reverse
  # Create an array of items to return
  discounted_items = []
  # Keep counters of items seen and discounted, to avoid having to recalculate on each iteration
  total_items_seen = 0
  discounted_items_seen = 0

  # Loop over all the items and find those to be discounted
  sorted_items.each do |line_item|
    total_items_seen += line_item.quantity
    # After incrementing total_items_seen, see if any items must be discounted
    count = discounted_items_to_find(total_items_seen, discounted_items_seen)
    # If there are none, skip to the next item
    next if count <= 0

    if count >= line_item.quantity
      # If the full item quantity must be discounted, add it to the items to return
      # and increment the count of discounted items
      discounted_items.push(line_item)
      discounted_items_seen += line_item.quantity
    else
      # If only part of the item must be discounted, split the item
      discounted_item = line_item.split(take: count)
      # Insert the newly-created item in the cart, right after the original item
      position = cart.line_items.find_index(line_item)
      cart.line_items.insert(position + 1, discounted_item)
      # Add it to the list of items to return
      discounted_items.push(discounted_item)
      discounted_items_seen += discounted_item.quantity
    end
  end

  # Return the items to be discounted
  discounted_items
end

eligible_items = Input.cart.line_items.select do |line_item|
  product = line_item.variant.product
  !product.gift_card? && ELIGIBLE_PRODUCT_IDS.include?(product.id)
end

discounted_line_items = partition(Input.cart, eligible_items)
discounted_line_items.each do |line_item|
  line_item.change_line_price(Money.zero, message: "Buy one, get one free!")
end

Output.cart = Input.cart
