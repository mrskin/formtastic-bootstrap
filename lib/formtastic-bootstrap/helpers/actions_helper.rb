module FormtasticBootstrap
  module Helpers
    module ActionsHelper

      include Formtastic::Helpers::ActionsHelper
      include FormtasticBootstrap::Helpers::FieldsetWrapper

      def action_wrapping(*args, &block) #:nodoc:
        contents = args.last.is_a?(::Hash) ? '' : args.pop.flatten
        html_options = args.extract_options!

        if block_given?
          contents = if template.respond_to?(:is_haml?) && template.is_haml?
            template.capture_haml(&block)
          else
            template.capture(&block)
          end
        end

        # Ruby 1.9: String#to_s behavior changed, need to make an explicit join.
        contents = contents.join if contents.respond_to?(:join)

        legend = field_set_legend(html_options)
        div = template.content_tag(:div,
          template.content_tag(:div,
            legend.html_safe + contents.html_safe,
            class: "col-lg-offset-3 col-lg-9"
          ),
          html_options.except(:builder, :parent, :name)
        )

        div
      end

      def actions(*args, &block)

        html_options = args.extract_options!
        html_options[:class] ||= "form-group"

        if block_given?
          action_wrapping(html_options, &block)
        else
          args = default_actions if args.empty?
          contents = args.map { |action_name| action(action_name) }
          action_wrapping(html_options, contents)
        end
      end

    end
  end
end
