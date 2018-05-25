# Conditionally Remove Vendors from the Cart with Buyer Country
For reasons that are not discussed in this document some vendors demand that products not be shipped to certain countries. How can you make that happen on Shopify Plus? You can use Scripts, and with this script you can remove products from the cart when they're matching a campaign defined.

### What is a Campaign
A campaign in the context of this script is a list of countries (`NOOP_${GROUP_NAME}`) of which a list of vendors (`VENDOR_NOOP_${GROUP_NAME}`) cannot be shipped to.

### Getting Started
Remove the example settings (lines 20-42) from `script.rb`.

### Create a new Campaign
Add two lists, `VENDOR_NOOP_${GROUP_NAME}` and `NOOP_${GROUP_NAME}`.

  1. Place vendor names in `VENDOR_NOOP_${GROUP_NAME}` formatted as a list
  2. Input all the countries you want to include in `NOOP_${GROUP_NAME}` in (ISO 3166-1 alpha-2)[https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2] format.

### Example

#### Do not ship

##### Do not ship to the EU

In this example we do not allow the vendors `JordansAwesomeBrand` and `Example2` to be shipped to any EU countries.

```VENDOR_NOOP_EU = ['JordansAwesomeBrand', 'Example2']
NOOP_EU = ['AT', 'BE', 'BG', 'CY', 'CZ', 'DK', 'EE', 'FI', 'FR', 'DE', 'GR', 'HU', 'IE', 'IT', 'IM', 'HR', 'EL', 'LV', 'LT', 'LU', 'MT', 'NL', 'PL', 'PT', 'RO', 'SK', 'SI', 'ES', 'SE', 'GB']

CAMPAIGNS = [
RemoveLineItemsCampaign.new(VENDOR_NOOP_EU, NOOP_EU)
]
```

##### Do not ship to Oceania

In this example we do not allow the vendors `Example1` to be shipped to any Oceania countries.
*limitation*: Hawaii is not supported because it uses the (ISO 3166-1 alpha-2)[https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2] code of the USA.

```VENDOR_NOOP_OCEANIA = ['Example1']
NOOP_OCEANIA = ['AU', 'NZ', 'NF', 'FJ', 'NC', 'PG', 'SB', 'VU', 'FM', 'GU', 'KI', 'MH', 'NR', 'MP', 'PW', 'UM', 'AS', 'CK', 'CL', 'PF', 'NU', 'PN', 'WS', 'TK', 'TO', 'TV', 'WF']

CAMPAIGNS = [
RemoveLineItemsCampaign.new(VENDOR_NOOP_OCEANIA, NOOP_OCEANIA)
]
```

##### Do not ship to the USA

In this example we do not allow the vendors `Example3` to be shipped to any of the United States.

```VENDOR_NOOP_US = ['Example3']
NOOP_US = ['US']

CAMPAIGNS = [
RemoveLineItemsCampaign.new(VENDOR_NOOP_US, NOOP_US)
]
```

#### Running multiple campaigns

##### How to:
Campaign is just a list, you can add another campaign to the list by adding a commar seperator `,` on the last campaign and then adding `RemoveLineItemsCampaign.new(VENDOR_NOOP_${GROUP_NAME}, NOOP_${GROUP_NAME})` on a new line.

```...
CAMPAIGNS = [
RemoveLineItemsCampaign.new(...),
RemoveLineItemsCampaign.new(VENDOR_NOOP_US, NOOP_US)
]
...
```

##### Example: Oceania & USA
```...
CAMPAIGNS = [
RemoveLineItemsCampaign.new(VENDOR_NOOP_OCEANIA, NOOP_OCEANIA),
RemoveLineItemsCampaign.new(VENDOR_NOOP_US, NOOP_US)
]
...
```
