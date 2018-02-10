## Provide Invoice Payment Option For Wholesale Orders

The [B2B ecommerce](https://www.shopify.com/enterprise/b2b-ecommerce-how-the-best-in-b2b-sales-succeed-online) is trillions larger than B2C ecommerce, so it’s important not to neglect these less glamorous sales. 

[Laird Superfoods](https://www.shopify.com/enterprise/how-laird-superfood-is-using-the-shopify-plus-wholesale-channel-to-increase-sales-550) was wrestling with an extremely manual B2B ecommerce process… “It was a really labor-intensive and time-consuming process,” Laird’s CEO Paul Hodge says. “We had to add to payroll and hire more staff just to take orders.”

When they switched to Shopify Plus, they were able to dedicate their team’s time to research and marketing, instead of constantly answering the phone. Sales now grow 15% per month, and 2017 Q2 year over year sales growth is at 550%. Their wholesale business is expected to expand to 75% of their company’s sales.

### How does it work?

_Note: this script can be utilized for Wholesale customers on the regular online storefront and/or expansion stores, not Shopify Plus' Wholesale channel._

   - `INVOICE_GATEWAY_NAME` on line 2 is the name of the invoice payment method you only want to offer to your Wholesale customers. This should be be loaded in as a _manual_ payment method in your Shopify Admin.  
   - `WHOLESALE_CUSTOMER_TAG` on line 5 is the customer tag that is eligible to select the payment option at checkout i.e. tag wholesale customers according to your input here to make them eligible.  
   - Only customers with the appropriate tag will be presented with the invoice payment option at checkout.

#### Credit
[Gavin Ballard](<script src="https://gist.github.com/gavinballard/094b7f456352c4946fb97656e90654cb.js"></script>)
