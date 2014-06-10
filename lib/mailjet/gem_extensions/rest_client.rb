module RestClient
  module Payload
    class Base
      def flatten_params_array value, calculated_key
        result = []
        value.each do |elem|
          if elem.is_a? Hash
            result += flatten_params(elem, calculated_key)
          elsif elem.is_a? Array
            result += flatten_params_array(elem, calculated_key)
          else
            result << ["#{calculated_key}", elem]
          end
        end
        result
      end
    end
  end
end
