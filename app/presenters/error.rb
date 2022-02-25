module Presenters
  class Error

    def initialize(message:)
      self.message = message
    end

    def to_json
      {
        message: message,
      }
    end

    private

    attr_accessor :message

  end
end