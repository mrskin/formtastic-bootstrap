module FormtasticBootstrap
  module Inputs
    module Base
      module Wrapping

        include Formtastic::Inputs::Base::Wrapping

        def bootstrap_wrapping(&block)
          input_content = [
            add_on_content(options[:prepend]),
            options[:prepend_content],
            yield,
            add_on_content(options[:append]),
            options[:append_content]
          ].compact.join("\n").html_safe

          control_group_wrapping do
            control_label_html <<
            controls_wrapping(label: true) do
              if prepended_or_appended?(options)
                [draw_addon_block(input_content), hint_html].join("\n").html_safe
              else
                [input_content, hint_html].join("\n").html_safe
              end
            end
          end
        end

        def prepended_or_appended?(options)
          options[:prepend] || options[:prepend_content] || options[:append] || options[:append_content]
        end

        def draw_addon_block(ic)
          template.content_tag(:div, :class => add_on_wrapper_classes(options).compact.join(" ")) do
            ic
          end
        end
        def add_on_content(content)
          return nil unless content
          template.content_tag(:span, content, :class => 'input-group-addon')
        end

        def control_group_wrapping(&block)
          template.content_tag(:div,
            template.capture(&block).html_safe,
            wrapper_html_options
          )
        end

        def controls_wrapping(args = {}, &block)
          template.content_tag(:div,
            [template.capture(&block), error_html].join("\n").html_safe,
            controls_wrapper_html_options(args)
          )
        end

        def controls_wrapper_html_options(args)
          if args[:label]
            {
              :class => "col-lg-9"
            }
          else
            # Add left offset if there are no labels
            {
              :class => "col-lg-offset-3 col-lg-9"
            }
          end
        end

        def wrapper_html_options
          super.tap do |options|
            options[:class] << " form-group"
            options[:class] << " has-error" if errors?
          end
        end

        def add_on_wrapper_classes(options)
          [:prepend, :append, :prepend_content, :append_content].map do |key|
            "input-group" if options[key]
          end
        end
      end
    end
  end
end
