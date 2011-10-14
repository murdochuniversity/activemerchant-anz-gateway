# Anz eGate

Provides an ActiveMerchant gateway to interface with ANZ's eGate.

## Usage

This is now available as a gem, as long as you have it in your Gemfile you can use bundler.

Gemfile

    source :rubygems

    gem 'activemerchant-anz-gateway'

Basic Usage

    require 'bundler'
    Bundler.require

    # Your merchant must have operators, to test prefix your merchant name with TEST
    gateway = ActiveMerchant::Billing::AnzGateway.new(
      :merchant_id => 'TESTANZMURCONREG', 
      :access_code => '31C43EF3'
    )

    # ANZ only require the card number, month and year
    card = ActiveMerchant::Billing::CreditCard.new(
      :number => '5123456789012346',
      :month  => 5,
      :year   => 2013
    )

    params = {
      :order_id => 'X123F',
      :invoice  => '10001'
    }

    # $10 puchase
    result = gateway.purchase(1000, card, params)

Other Features

There are features for refuding/crediting and querying past records, however these are missing tests and I can't vouch for them.

You can manage your anz merchant account over at https://migs.mastercard.com.au/ma

## Testing

Anz seem to have removed their public testing profile, I've instead set the fixtures to come from environment variables

    export ANZ_MERCHANT=TESTyoumerchantname
    export ANZ_CODE=youroperatorcode

To set up your testing environment you will need to log in as the _Administrator_ using your merchantid prefixed by test. The password will be the same as your production account.

## Acknowledgements

I had pretty much nothing to do with this library, I just made it into a gem and check on the tests. This is a fork of [Anuj Luthra's](https://github.com/anujluthra) [fantastic work](https://github.com/anujluthra/activemerchant-anz-gateway).

# LICENCE

Licenced under MIT Copyright 2009 by Anuj Luthra, for details see LICENCE