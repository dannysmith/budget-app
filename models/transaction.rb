class Transaction
  include Mongoid::Document

  belongs_to :user
  has_and_belongs_to_many :tags

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
  field :merchant_zoom, type: String
  field :merchant_postcode, type: String
  field :merchant_region, type: String
  field :merchant_id, type: String
  field :merchant_logo, type: String
  field :merchant_emoji, type: String
  field :merchant_name, type: String
  field :merchant_category, type: String

  # Counterparty
  field :counterparty_name, type: String
  field :counterparty_prefered_name, type: String
  field :counterparty_phone, type: String
  field :counterparty_user_id, type: String

  def f_amount
    if amount < 0
      Money.new(self.amount * -1, self.currency).format
    else
      "+ #{Money.new(self.amount, self.currency).format}"
    end
  end

  def f_balance
    Money.new(self.account_balance, self.currency).format
  end

  def self.make(username, data)
    user = User.find_by(username: username)

    unless user.transactions.find_by monzo_transaction_id: data['id']
      tx_hash = {
        user: username,
        monzo_account_id: data['account_id'],
        amount: data['amount'],
        account_balance: data['account_balance'],
        created: data['created'],
        currency: data['currency'],
        notes: data['notes'],
        description: data['description'],
        monzo_transaction_id: data['id'],
        monzo_category: data['category'],
        is_load: data['is_load']
      }

      if data['counterparty']
        tx_hash.merge!({
          counterparty_name: data['counterparty']['name'],
          counterparty_prefered_name: data['counterparty']['prefered_name'],
          counterparty_phone: data['counterparty']['number'],
          counterparty_user_id: data['counterparty']['user_id']
        })
      end

      if data['merchant']
        tx_hash.merge!({
          atm: data['merchant']['atm'],
          online: data['merchant']['online'],
          merchant_id: data['merchant']['id'],
          merchant_logo: data['merchant']['logo'],
          merchant_emoji: data['merchant']['emoji'],
          merchant_name: data['merchant']['name']
        })

        if data['merchant']['address']
          tx_hash.merge!({
            merchant_address: data['merchant']['address']['short_formatted'],
            merchant_city: data['merchant']['address']['city'],
            merchant_country: data['merchant']['address']['country'],
            merchant_lat: data['merchant']['address']['latitude'],
            merchant_long: data['merchant']['address']['longitude'],
            merchant_zoom: data['merchant']['address']['zoom_level'],
            merchant_postcode: data['merchant']['address']['postcode'],
            merchant_region: data['merchant']['address']['region'],
          })
        end
      end
      user.transactions << self.create(tx_hash)
    else
      STDERR.puts "Transaction already exists"
    end
  end
end
