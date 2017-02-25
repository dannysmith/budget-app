class Tag
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  validates :name, presence: true
  validates :name, uniqueness: true

  belongs_to :user
  has_and_belongs_to_many :transactions
end
