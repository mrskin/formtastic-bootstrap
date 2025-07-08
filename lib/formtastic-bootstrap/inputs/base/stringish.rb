module FormtasticBootstrap
  module Inputs
    module Base
      module Stringish

        include Formtastic::Inputs::Base::Stringish

        def to_html
          bootstrap_wrapping do
            builder.text_field(method, input_html_options)
          end
        end
        def input_html_options
          {
            class: 'form-control'
          }.merge(super)
        end

      end
    end
  end
end
