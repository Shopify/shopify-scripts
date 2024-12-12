# Define a list of price tiers.
PRICE_TIERS = [
  # Pricing tiers for Shoes
  {
    product_types: ['Shoes'],
    group_by: :product, # :product or :variant
    tiers: [
      {
        quantity: 10,
        discount_percentage: 10,
        discount_message: '10% off for 10+'
      },
      {
        quantity: 50,
        discount_percentage: 15,
        discount_message: '15% off for 50+'
      }
    ]
  }
]

# You shouldn't need to edit anything below this line, unless you're a developer
# and know what you're doing :).

##
# Tiered pricing campaign.
class TieredPricingCampaign

  def initialize(partitioner, tiers)
    @partitioner = partitioner
    @tiers = tiers.sort_by { |tier| tier[:quantity] }
  end

  def run(cart)
    @partitioner.partition(cart).each do |k, items|
      total_quantity = items.map(&:quantity).reduce(0, :+)
      applicable_tier = find_tier_for_quantity(total_quantity)
      unless applicable_tier.nil?
        apply_tier_discount(items, applicable_tier)
      end
    end
  end

  private

    def find_tier_for_quantity(quantity)
      @tiers.select { |tier| tier[:quantity] <= quantity }.last
    end

    def apply_tier_discount(items, tier)
      discount = get_tier_discount(tier)
      items.each do |item|
        discount.apply(item)
      end
    end

    def get_tier_discount(tier)
      PercentageDiscount.new(tier[:discount_percentage], tier[:discount_message])
    end

end

##
# Select line items by product type.
class ProductTypeSelector

  def initialize(product_types)
    @product_types = Array(product_types).map(&:upcase)
  end

  def match?(line_item)
    @product_types.include?(line_item.variant.product.product_type.upcase)
  end

  def group_key
    @product_types.join(',')
  end

end

##
# Apply a percentage discount to a line item.
class PercentageDiscount

  def initialize(percent, message = '')
    @percent = Decimal.new(percent) / 100.0
    @message = message
  end

  def apply(item)
    line_discount = item.original_line_price * @percent
    new_line_price = item.original_line_price - line_discount
    if new_line_price < item.line_price
      item.change_line_price(new_line_price, message: @message)
    end
  end

end

##
# A pricing tier partition.
class TierPartitioner

  def initialize(selector, group_by)
    @selector = selector
    @group_by = group_by
  end

  def partition(cart)
    # Filter items
    items = cart.line_items.select { |item| @selector.match?(item) }

    # Group items using the appropriate key.
    items.group_by { |item| group_key(item) }
  end

  private

    def group_key(line_item)
      case @group_by
        when :product
          line_item.variant.product.id
        when :variant
          line_item.variant.id
        else
          @selector.group_key
      end
    end

end

##
# Instantiate and run Price Tiers.
PRICE_TIERS.each do |pt|
  TieredPricingCampaign.new(
    TierPartitioner.new(
      ProductTypeSelector.new(pt[:product_types]),
      pt[:group_by]
    ),
    pt[:tiers]
  ).run(Input.cart)
end

##
# Export changes.
Output.cart = Input.cart
