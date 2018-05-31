## VIP Membership Discount

A simple variation on the [10% off sitewide](https://github.com/Shopify/shopify-scripts/tree/master/Line%20Item%20Scripts/10%20percent%20off%20storewide) script, this script will allow you to conditionally apply that discount based on customer tag. Useful for when you only want to give certain customers a sitewide discount as part of a membership or VIP program of some sort.

_This will exclude Gift Card purchases._

### What it does

The default script will give customers with the tag `MEMBERSHIP` 10% off every item in their cart. You can adjust the following properties:
   - `DISCOUNT_AMOUNT`: Percentage discount given to certain customers. Default is 10.  
   - `CUSTOMER_TAG`: Eligible customer tags to receive the discount. Separate eligible tags with a comma if several tags have discount access.  
   - You can adjust the discount message on line 8 accordingly.

#### Credit

This is a variation of [Gavin Ballard's](https://gist.github.com/gavinballard/0b274716792a8408e3e9a41561bf9a02) original script.
