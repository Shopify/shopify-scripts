## Fallback Rates for External Carriers

### What does it do?

This shipping script is a bit esoteric, but it's useful for high-volume stores, where even a few minutes of downtime on the part of a third party shipping calcluation app could result in lost sales.

This script assumes that you're using one or more third party carrier APIs for fetching shipping rates (CARRIER_SOURCES), and that you've also set up some "fallback" rates in Shopify as a backup. If any carrier rates are present, this script will hide the fallback Shopify rates. If they're not (eg because the third party is down or times out), the fallback rates remain.

#### Credit
[Gavin Ballard](https://gist.github.com/gavinballard/324196edc7f11c530dd77218e7dfeb67)
