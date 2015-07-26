module Exceptions
  # General error for account access faults
  class AccessError < StandardError; end

  # Error to raise in case of invalid account access
  class UnauthorizedAccountRole < AccessError
    attr_writer :default_message

    def initialize(message = nil)
      @message = message
      @default_message = I18n.t(:"unauthorizedAccountRole.default", default: "Your account is unauthorized for that action.")
    end

    def to_s
      @message || @default_message
    end
  end

  # General error for parameters
  class ParamError < StandardError; end

  # Error in case of an unrecognized parameter
  class UnrecognizedParameter < ParamError
  end

end
