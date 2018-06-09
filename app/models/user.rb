class User < ActiveRecord::Base
	
	# This is what amkes the User object password protected, by using the authlogic gem
  acts_as_authentic do |c|
    #c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
		
		# need to set the crypto provider to the older one, since it's not the default anymore (Greg N)
		c.crypto_provider = Authlogic::CryptoProviders::Sha512
		
    c.validate_email_field = false
  end # block optional

end
