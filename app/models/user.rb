class User < ActiveRecord::Base
  include Sluggable
    sluggable_column :username
    
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 3}

  def admin?
    self.role == "admin"
  end


  def two_factor_auth?
    !self.phone.blank?
  end


  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) #random 6 digit number
  end


  def remove_pin!
    self.update_column(:pin, nil)
  end


  def send_pin_to_twilio
    # put your own credentials here 
    account_sid = 'ACc57c7b4437927bbd7143801389af02b9' 
    auth_token = 'd4718338dfca0525315c1b2101cc69fb' 
 
    # set up a client to talk to the Twilio REST API 
    client = Twilio::REST::Client.new account_sid, auth_token 
 

    msg = "Thanks for trying out my Postit app. Here's your PIN: #{self.pin}"
    client.account.messages.create({
      :from => '+19703997887', :to => "#{self.phone}", :body => msg   
    })
  end

end