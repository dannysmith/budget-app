class User
  include Mongoid::Document

  field :fullname, type: String
  field :username, type: String

  validates :fullname, presence: true
  validates :username, presence: true
  validates :username, uniqueness: true

  has_many :transactions
  has_many :tags

  def password
    ENV["PASSWORD_#{self.username.upcase}"]
  end

  def create_tag(name)
    return nil if self.tags.find_by tagname: name
    self.tags.create! name: name
  end
end
