# Budgeting Web App

This is the data that is received with a webhook:

```ruby
{
    "type" => "transaction.created",
    "data" => {
                         "id" => "tx_00009Hn5MBlVZ3S4cFukSH",
                    "created" => "2017-02-25T14:39:06.283Z",
                "description" => "Transfer to +447590010780",
                     "amount" => -1,
                   "currency" => "GBP",
                   "merchant" => nil,
                      "notes" => "Testing monzo API. Expect more mini-payments. ",
                   "metadata" => {
                          "notes" => "Testing monzo API. Expect more mini-payments. ",
                "p2p_transfer_id" => "p2p_00009Hn5MAMInHhAFn76Wn"
            },
            "account_balance" => 2766,
                "attachments" => nil,
                   "category" => "mondo",
                    "is_load" => true,
                    "settled" => "2017-02-25T14:39:06.283Z",
               "local_amount" => -1,
             "local_currency" => "GBP",
                    "updated" => "2017-02-25T14:39:06.685Z",
                 "account_id" => "acc_000096IWwHKKWroPDAwlqz",
               "counterparty" => {
                         "number" => "+447590010780",
                        "user_id" => "user_000096OT89DTHBFbgKG8uH"
                    },
                     "scheme" => "gps_mastercard",
                  "dedupe_id" => "825748006220110445",
                 "originator" => true,
        "include_in_spending" => true
    }
}
```

and this:

```ruby
{
    "type" => "transaction.created",
    "data" => {
                         "id" => "tx_00009Hn9RR8QFRBnJ1ntTt",
                    "created" => "2017-02-25T15:24:52.15Z",
                "description" => "TESCO-STORES 6409      LONDON        GBR",
                     "amount" => -247,
                   "currency" => "GBP",
                   "merchant" => {
                          "id" => "merch_0000955VXV55aAdiDb9NeD",
                    "group_id" => "grp_000092JYpvjM7VZJ1X0Ukr",
                     "created" => "2016-02-11T15:39:58.185Z",
                        "name" => "Tesco",
                        "logo" => "https://mondo-logo-cache.appspot.com/twitter/tesco/?size=large",
                       "emoji" => "🍏",
                    "category" => "groceries",
                      "online" => false,
                         "atm" => false,
                     "address" => {
                "short_formatted" => "291-295 Holloway Road, London N19 4HW",
                      "formatted" => "291-295 Holloway Road, London N19 4HW, United Kingdom",
                        "address" => "291-295 Holloway Road",
                           "city" => "London",
                         "region" => "Greater London",
                        "country" => "GBR",
                       "postcode" => "N19 4HW",
                       "latitude" => 51.5650921,
                      "longitude" => -0.1333918,
                     "zoom_level" => 17,
                    "approximate" => false
            },
                     "updated" => "2016-03-30T10:34:50.068Z",
                    "metadata" => {
                    "created_for_merchant" => "merch_000092JYpvhEFProuw0nRJ",
                 "created_for_transaction" => "tx_0000955VXUquQsfyky1t2n",
                     "foursquare_category" => "Grocery Store",
                "foursquare_category_icon" => "https://ss3.4sqi.net/img/categories_v2/shops/food_grocery_88.png",
                           "foursquare_id" => "4fa002a07beb7ebce8fb6ffb",
                      "foursquare_website" => "http://www.tesco.com",
                      "google_places_icon" => "https://maps.gstatic.com/mapfiles/place_api/icons/generic_business-71.png",
                        "google_places_id" => "ChIJ3QIYWa4bdkgRULT697YHGzU",
                      "google_places_name" => "Tesco Express",
                          "suggested_name" => "Tesco Express",
                          "suggested_tags" => "#shopping #food",
                              "twitter_id" => "tesco",
                                 "website" => "http://www.tesco.com"
            },
            "disable_feedback" => false
        },
                      "notes" => "",
                   "metadata" => {},
            "account_balance" => 2519,
                "attachments" => nil,
                   "category" => "groceries",
                    "is_load" => false,
                    "settled" => "",
               "local_amount" => -247,
             "local_currency" => "GBP",
                    "updated" => "2017-02-25T15:24:52.56Z",
                 "account_id" => "acc_000096IWwHKKWroPDAwlqz",
               "counterparty" => {},
                     "scheme" => "gps_mastercard",
                  "dedupe_id" => "825748006170225813810016103",
                 "originator" => false,
        "include_in_spending" => true
    }
}
```
