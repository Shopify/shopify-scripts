# Shopify Scripts Public Repository

Shopify Scripts are customizations written in Ruby that allow you to create personalized customer experiences. Using line item, shipping, and payment scripts you can implement custom logic and tailor the user experience during a customer’s checkout journey. Scripts are enabled on a store’s checkout by using the Script Editor app.

_This repository is administered by Shopify Plus for the purposes of collaboration among our community of merchants and partners. However, scripts submitted are not vetted or supported by Shopify._

## How they work
Shopify Scripts are written in a stripped-down version of Ruby, and work by receiving an “input” of the cart, customer, and shipping methods or payment gateways, run the script code to perform modifications, and then return the result as an “output” which is then applied to the cart or checkout. The Script Editor app hosts scripts you’ve created on Shopify’s servers, allowing them to affect the cart and checkout at a fundamental level without the need of third-party apps or externally hosted plugins.

There are three different types of Shopify Scripts:

1. Line item scripts affect line items in the cart and can change prices and grant discounts. Note: Theme modifications may be required to the show the discount amount or messages in the cart and checkout.
2. Shipping scripts interact with shipping, and can rename, show, hide, or reorder shipping methods and grant discounts on shipping rates.
3. Payment scripts interact with payments, and can rename, show, hide, or reorder payment gateways.

_**Note:** payment scripts do not interact with payment gateways shown before the checkout._

## Using this Repo
Within this repo you can:

### 1. Use examples as a template to build your own scripts
Scripts are organized into 3 categories within the repository:
- Line Item
- Shipping
- Payment

When searching for a script to use, first open the relevant folder for the script type you are looking for. The `README.md` file will contain all the information about what the script does. The script file will be <scriptname.rb> - this is the file you will open and add into the Script Editor App on your store.

### 2. Submit a script to the community
When submitting a script:
- Ensure you are submitting your script within the relevant folder
- Create a new folder for your script and name it appropriately
- Include a README.md file explaining what the script does and any other appropriate information using this format.
- Include your script as a <scriptname>.rb file
- Submit a Pull Request to have your script added to the repository

## Script Creation Tools
There are tools out in the wild that aid in the creation of scripts based on plug and play variables. Jason Godson has created a Shopify Script Creator where you can generate scripts and manually paste them into your store. There are also tools like Disco Labs Playwright that are integrated into your store as an app.

## Scripts Ruby API & Liquid Variables
Shopify provides Ruby API documentation which is accessible via the Script Editor. This API is used to write the custom logic which runs in the checkout as is documented here: 

This API differs from the Liquid variables exposed to scripts. These are used by scripts to communicate changes to the storefront and checkout. An example would be the message which appears next to a discount in the cart. This documentation can be found here.

## Best Practices and Optimization
- Only 1 script of each type can be published at a time. This often results in monolithic scripts which “do everything” the merchant needs. This in turn often leads to memory, CPU and character limitation issues. The solution to this is to refactor scripts to apply generic conditions based on parameters exposed to scripts, for example line item properties and tags. A script with hundreds of product IDs listed to enable bundle discounting should be refactored to look for a product tag instead.
- Using Ruby’s safe navigation operator (&.) is a great idea to avoid “Nil” errors. 
- Minimise loops. Can you achieve what you’re trying to achieve without looping over all line items? If so, take that route.
- Add code comments so that others can understand what the script does and can debug it. 
- Keep your code as DRY (Don’t Repeat Yourself) as possible, avoid repetition, and abstract away common functionality.
- Test your scripts both in the editor and in the checkout preview.
- Test your scripts with a large number of line items and varying line item quantities. This will avoid unexpected CPU or execution time errors.
- Watch out for rounding issues. We have limited control over rounding in scripts and it’s not uncommon to find that a discount applied has caused a rounding issue at the line item level price or line price level. This can cause issues with ERPs and other integrations.
- You can schedule Shopify Scripts to publish with Launchpad.

## Noteworthy Limitations
- Only 1 script of each type can be published at a time. 
- Script types (line item, shipping, payments) are tightly scoped which means variable availability can be an issue. For example, a customers chosen shipping method isn’t available in a payment script.
- This tight scoping also results in the following common issues:  
   - No access to metafields  
   - No access to the collection(s) a product belongs to  
   - No access to cart/checkout attributes
- Regular expression pattern matching is not available in scripts which makes pattern matching a challenge. Date and time is also not available.
- Shopify Scripts have memory, CPU, and character limitations imposed for security and performance reasons. 
- Scripts are limited to the Online Store channel only:  
   - Scripts are not supported in the wholesale channel checkout  
   - Scripts do not fire when used in conjunction with the Buy Button  
   - Scripts do not fire when sending a draft order invoice to a customer  
   - Note: Scripts DO fire if using checkout permalinks
- Scripts cannot display messaging in the checkout without modifications to checkout.liquid
- Theme modifications are required to show the discount off of the original price and any messages in the cart
