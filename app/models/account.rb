class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :saml_authenticatable, :trackable #, :registerable,
         #:recoverable, :rememberable, :trackable, :validatable


  def set_user_saml_attributes(user,attributes)
    puts user
    puts attributes
    #attribute_map.each do |k,v|
      #Rails.logger.info "Setting: #{v}, #{attributes[k]}"
      #user.send "#{v}=", attributes[k]
    #end
  end
end
