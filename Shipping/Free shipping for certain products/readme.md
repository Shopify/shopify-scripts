## Free shipping for certain products

Want to offer free shipping, but only on certain products? This script will conditionally discount your cheapest shipping rate to $0 and include a message that says `Free Shipping!` at checkout, but only when products in the cart include a certain tag. _All_ products in the cart must include the applicable tag in order for free shipping to apply.

### How does it work?

Products that have certain tags are given free shipping at checkout (_all_ products in the cart must have the associated tag in order to qualify for free shipping). The default script uses the product tag `freeship`. You can use the default product tag, or change this on line 1 of the script and then tag your products appropriately.

Secondly, this script by default includes a country selector to only offer the free shipping within the United States, using the country code selector. You can:
   - Change the country code selector to your own preferred countries using [ISO country code standards](https://en.wikipedia.org/wiki/ISO_3166-1)  
   - Remove the country variable entirely so that products per the eligible product tags are given free shipping _everywhere_. To do this remove the preceding `if Input.cart.shipping_address.country_code == 'US' && ` on line 3.
