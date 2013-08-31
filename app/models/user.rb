class User < ActiveRecord::Base
  has_many :rounds
  has_many :decks, through: :rounds

  validates :name, presence: true
  
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  validates :password, presence: true # this isn't working. because we're using bcrypt create. 

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    (user && user.password == password) ? user : nil
  end

  def self.create(user)
    @user = User.new(name: user[:name],
                     email: user[:email])
    @user.password = user[:password]
    @user.save
    @user
  end
end

