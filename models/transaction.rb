class Transaction
  include Mongoid::Document

  field :user, type: String

  # TX Details
  field :monzo_account_id, type: String
  field :amount, type: Integer
  field :account_balance, type: Integer
  field :created, type: DateTime
  field :currency, type: String
  field :description, type: String
  field :monzo_transaction_id, type: String
  field :monzo_category, type: String
  field :notes, type: String
  field :is_load, type: Boolean
  field :online, type: Boolean
  field :atm, type: Boolean

  # Merchant Details
  field :merchant_address, type: String
  field :merchant_city, type: String
  field :merchant_country, type: String
  field :merchant_lat, type: String
  field :merchant_long, type: String
  field :merchant_postcode, type: String
  field :merchant_region, type: String
  field :merchant_id, type: String
  field :merchant_logo, type: String
  field :merchant_emoji, type: String
  field :merchant_name, type: String
  field :merchant_category, type: String

  def self.make(user, data)
    tx_hash = {
      user: user,
      monzo_account_id: data['account_id'],
      amount: data['amount'],
      account_balance: data['account_balance'],
      created: data['created'],
      currency: data['currency'],
      notes: data['notes'],
      description: data['description'],
      monzo_transaction_id: data['id'],
      monzo_category: data['category'],
      is_load: data['is_load'],
      atm: data['merchant']['atm'],
      online: data['merchant']['online'],
      merchant_address: data['merchant']['address']['short_formatted'],
      merchant_city: data['merchant']['address']['city'],
      merchant_country: data['merchant']['address']['country'],
      merchant_lat: data['merchant']['address']['latitude'],
      merchant_long: data['merchant']['address']['longitude'],
      merchant_postcode: data['merchant']['address']['postcode'],
      merchant_region: data['merchant']['address']['region'],
      merchant_id: data['merchant']['id'],
      merchant_logo: data['merchant']['logo'],
      merchant_emoji: data['merchant']['emoji'],
      merchant_name: data['merchant']['name'],
      merchant_category: data['']
    }
    self.create(tx_hash)
  end
end
