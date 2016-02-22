class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :rememberable, :omniauthable
  has_many :diagrams_users, dependent: :destroy
  has_many :diagrams, through: :diagrams_users, dependent: :destroy
  has_many :shared_diagrams , -> { where shared: true }, class_name: "DiagramsUser"
  has_many :own_diagrams , -> { where shared: nil}, class_name: "DiagramsUser"

  def editor?
    self.role == 'editor'
  end

  def admin?
    self.role == 'admin'
  end

  def editor_or_admin?
    self.editor? or self.admin?
  end



  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  #validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user
    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      #email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      #email = auth.info.email if email_is_verified
      #user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
            name: auth.extra.raw_info.name,
            #username: auth.info.nickname || auth.uid,
            #email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
            #password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation! if user.respond_to?(:skip_confirmation)
        #user.save
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      #identity.save
    end
    identity.user_id = user.id
    identity.save!
    user
  end
end
