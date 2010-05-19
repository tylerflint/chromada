require 'digest/sha1'

class Employee < ActiveRecord::Base
  # include Authentication
  # include Authentication::ByPassword
  # include Authentication::ByCookieToken

  mattr_accessor :name_regex, :bad_name_message,
    :email_name_regex, :domain_head_regex, :domain_tld_regex, :email_regex, :bad_email_message
    
  self.email_name_regex  = '[\w\.%\+\-]+'.freeze
  self.domain_head_regex = '(?:[A-Z0-9\-]+\.)+'.freeze
  self.domain_tld_regex  = '(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)'.freeze
  self.email_regex       = /\A#{email_name_regex}@#{domain_head_regex}#{domain_tld_regex}\z/i
  self.bad_email_message = "should look like an email address.".freeze
  
  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => self.email_regex, :message => self.bad_email_message
  
  attr_accessor :password
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :password, :within => 6..40, :if => :password_required?
  before_save :encrypt_password

  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation, :firstname, :lastname, :notes


  class << self
    # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
    #
    # uff.  this is really an authorization, not authentication routine.  
    # We really need a Dispatch Chain here or something.
    # This will also let us return a human error message.
    #
    def authenticate(login, password)
      return nil if login.blank? || password.blank?
      u = find_by_email(login.downcase) # need to get the salt
      u && u.authenticated?(password) ? u : nil
    end
    
    def secure_digest(*args)
      Digest::SHA1.hexdigest(args.flatten.join('--'))
    end

    def make_token
      secure_digest(Time.now, (1..10).map{ rand.to_s })
    end
    
    # This provides a modest increased defense against a dictionary attack if
    # your db were ever compromised, but will invalidate existing passwords.
    # See the README and the file config/initializers/site_keys.rb
    #
    # It may not be obvious, but if you set REST_AUTH_SITE_KEY to nil and
    # REST_AUTH_DIGEST_STRETCHES to 1 you'll have backwards compatibility with
    # older versions of restful-authentication.
    def password_digest(password, salt)
      digest = REST_AUTH_SITE_KEY
      REST_AUTH_DIGEST_STRETCHES.times do
        digest = secure_digest(digest, salt, password, REST_AUTH_SITE_KEY)
      end
      digest
    end
    
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def login
    email
  end
  
  def name
    [firstname, lastname].join " "
  end
  
  def status
    ''
  end
  
  def photo
    ''
  end

  def generate_password
      self.password = 'password'
      self.password_confirmation = 'password'
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.password_digest(password, salt)
  end
  
  def authenticated?(password)
    crypted_password == encrypt(password)
  end
  
  # before filter 
  def encrypt_password
    return if password.blank?
    self.salt = self.class.make_token if new_record?
    self.crypted_password = encrypt(password)
  end
  
  def password_required?
    crypted_password.blank? || !password.blank?
  end

  def remember_token?
    (!remember_token.blank?) && 
      remember_token_expires_at && (Time.now.utc < remember_token_expires_at.utc)
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = self.class.make_token
    save(false)
  end

  # refresh token (keeping same expires_at) if it exists
  def refresh_token
    if remember_token?
      self.remember_token = self.class.make_token 
      save(false)      
    end
  end

  # 
  # Deletes the server-side record of the authentication token.  The
  # client-side (browser cookie) and server-side (this remember_token) must
  # always be deleted together.
  #
  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end
  
end
