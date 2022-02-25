module SchemaValidators
  module Game
    class Create

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
          "required" => ["duration", "random"],
          "properties" => {
            "duration" => { "type" => "integer" },
            "random" => { "type" => "boolean" }
          }
        }
      end

      attr_accessor :input
    end
  end
end
