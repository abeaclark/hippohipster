class User < ActiveRecord::Base
  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password_plaintext)
    p password_plaintext
    p self.password
    p self.password == password_plaintext
    return (self.password == password_plaintext)
  end

end
