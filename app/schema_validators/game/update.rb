module SchemaValidators
  module Game
    class Update

      def initialize(input:)
        self.input = input
      end

      def valid?
        JSON::Validator.validate(
          schema, input
        )
      end

      private

      def schema
        {
          "type" => "object",
          "required" => ["id", "token", "word"],
          "properties" => {
            "id" => { "type" => "integer" },
            "token" => { "type" => "string" },
            "word" => { "type" => "string" }
          }
        }
      end

      attr_accessor :input
    end
  end
end