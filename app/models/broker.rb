class Broker < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :saml_authenticatable, :trackable#, :registerable,
         #:recoverable, :rememberable, :trackable, :validatable

  Devise.setup do |config|
    # ==> Configuration for :saml_authenticatable
    # Create user if the user does not exist. (Default is false)
    config.saml_create_user = true

    # Set the default user key. The user will be looked up by this key. Make
    # sure that the Authentication Response includes the attribute.
    config.saml_default_user_key = :email

    # Optional. This stores the session index defined by the IDP during login.  If provided it will be used as a salt
    # for the user's session to facilitate an IDP initiated logout request.
    config.saml_session_index_key = :session_index

    # You can set this value to use Subject or SAML assertation as info to which email will be compared
    # If you don't set it then email will be extracted from SAML assertation attributes
    config.saml_use_subject = true

    # Configure with your SAML settings (see [ruby-saml][] for more information).
    config.saml_configure do |settings|
      settings.assertion_consumer_service_url     = "http://localhost:8080/brokers/saml/auth"
      settings.assertion_consumer_service_binding = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
      settings.name_identifier_format             = "urn:oasis:names:tc:SAML:2.0:nameid-format:transient"
      settings.issuer                             = "https://app.onelogin.com/saml/metadata/#{ENV['ONE_LOGIN_APP_ID_BROKER']}"
      settings.authn_context                      = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"
      settings.idp_sso_target_url                 = "https://marmar-is.onelogin.com/trust/saml2/http-post/sso/#{ENV['ONE_LOGIN_APP_ID_BROKER']}"
      settings.idp_slo_target_url                 = "https://marmar-is.onelogin.com/trust/saml2/http-redirect/slo/#{ENV['ONE_LOGIN_APP_ID_BROKER']}"
      settings.idp_cert                           = <<-CERT.chomp
-----BEGIN CERTIFICATE-----
MIIEGjCCAwKgAwIBAgIUc7s30jcxy+Z71Gow0N4WxdNTbT8wDQYJKoZIhvcNAQEF
BQAwWTELMAkGA1UEBhMCVVMxEjAQBgNVBAoMCW1hcm1hci1pczEVMBMGA1UECwwM
T25lTG9naW4gSWRQMR8wHQYDVQQDDBZPbmVMb2dpbiBBY2NvdW50IDY2MzQ2MB4X
DTE1MDcyMDA1MzAxNVoXDTIwMDcyMTA1MzAxNVowWTELMAkGA1UEBhMCVVMxEjAQ
BgNVBAoMCW1hcm1hci1pczEVMBMGA1UECwwMT25lTG9naW4gSWRQMR8wHQYDVQQD
DBZPbmVMb2dpbiBBY2NvdW50IDY2MzQ2MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAppEwfGOd8sw5vZuQlyEUXhn++pNqxFf9oUj87cXILMqMbh+MMMrd
5te9rJrql9qzpURe6sz6e1BwIDu0n7GQ7yGiv4jN9UIEatqeHRXp2wWaLxyA8RzP
oZCCZxMw+FN3VfRRZ1t3R0cVqxmu/E9Hfq7Ac87Qm7jxM1yBFQpR5uTQJdvI4jKM
mFds9oR6kzcOsDHJYaDbQ1G0u8z/2PezjsGarRd9mpAcivW0OcCmBIFislEJWK8Y
oauB7hO9Y7FXdf2wYDX8PGSrQL+YJlv9Ew9WEDxb2XxxXjanHo8fh8jhAaAXLtQh
CA3cql9drSgDgHbBhXgI0A6oWHeX3ZJ6BwIDAQABo4HZMIHWMAwGA1UdEwEB/wQC
MAAwHQYDVR0OBBYEFARSxLAxDEl3Nhb0p7i6qbqcqhCDMIGWBgNVHSMEgY4wgYuA
FARSxLAxDEl3Nhb0p7i6qbqcqhCDoV2kWzBZMQswCQYDVQQGEwJVUzESMBAGA1UE
CgwJbWFybWFyLWlzMRUwEwYDVQQLDAxPbmVMb2dpbiBJZFAxHzAdBgNVBAMMFk9u
ZUxvZ2luIEFjY291bnQgNjYzNDaCFHO7N9I3Mcvme9RqMNDeFsXTU20/MA4GA1Ud
DwEB/wQEAwIHgDANBgkqhkiG9w0BAQUFAAOCAQEAS1rk45A6DHqhvdC2bmUMUzXd
nLf65Ec8XhhBCdyv8HbVqxpf4jQsuU3RYzs9YJQyuF+JjVF0Ek/dIUptYLUArBpG
uM3c3Uruqjck+oBX8mzUHGUTR1l3Sb4VOayRpdUCcjaRj1USoPwaegUfoDHt6tQk
Kt12v+IWZTmG/1NaRi385t+B947cWyZi3gKliCpF8x7EmS7ovJZTUKBaXUiNoFRJ
0FKgxLWsqmdVqUvhQbGChowu6zcHI+T2WUph6gbPJbOLhLs3OBsWOt2vtSKVVK+i
2uU2idgl6jgAeqqk5Y9VUsrSuq8Le78Lx6/wHGAk8VtVdU/KXuLSSmikg3lcSQ==
-----END CERTIFICATE-----

      CERT
    end
  end
end
