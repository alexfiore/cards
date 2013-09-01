class User < ActiveRecord::Base
  attr_accessible :email, :password, :name
  has_many :rounds
  has_many :decks, through: :rounds

  validates :name, presence: true
  
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  validates :password, presence: true, allow_blank: false # this isn't working. because we're using bcrypt create. 

  include BCrypt

  attr_reader :password

  # def password
  #   @password ||= Password.new(password_hash)
  # end

  def password=(new_password)
    @password = new_password
    self.password_hash = Password.create(new_password) unless new_password.blank?
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    (user && Password.new(user.password_hash) == password) ? user : nil
  end
end

