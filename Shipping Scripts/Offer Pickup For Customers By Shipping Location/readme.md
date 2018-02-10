## Offer Pickup For Customers By Shipping Location

Whether shipping is free or not, online customers might want to save time and just go into a physical store to pick up their product. This can save time and effort on the part of the distributor, but it has to be incentivized correctly.

Warby Parker used the [locations of its online consumers](https://retail.emarketer.com/article/warby-parkers-growing-ambitions/59824b5cebd40003acdf2ddf) to gauge opportunities for opening physical stores. Over 75% of customers that buy at its stores browse online before coming in and enjoy the physical experience of the store.

### How does it work?

You should create a new "pick up" shipping rate within your Shopify Admin. The name of this rate should equal the `PICKUP_SHIPPING_RATE_NAME` variable on line 2 of the script. Then, define post codes that are eligible to pick up from your store using the `PICKUP_POSTCODE_PREFIXES` variable on lines 5 + 6. Customers who "ship" to addresses within these post codes will be given the option to pick up in store, along with regular shipping options.

#### Credit
[Gavin Ballard](https://gist.github.com/gavinballard/3b1e596ea657b9944ce00ef2764f0e76)
