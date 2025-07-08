module FormtasticBootstrap
  module Inputs
    module Base
      module Placeholder
        include Formtastic::Inputs::Base::Placeholder

        def placeholder_text
          if options[:placeholder] == false
            nil
          else
            humanized_method_name
          end
        end
      end
    end
  end
end