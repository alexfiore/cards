class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :rounds
  has_many :decks, through: :rounds

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
                     email: user[:email]
                      )
    @user.password = user[:password]
    @user.save
    @user
  end
end

