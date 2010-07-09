module GoogleVisualr
  module Formatters
  
    class BaseFormat

      # http://code.google.com/apis/visualization/documentation/reference.html#formatters

      attr_accessor :columns

      def initialize(options = {})
        options.each_pair do | key, value |
          self.send "#{key}=", value
        end
      end

      def columns(*columns)
        @columns = columns.flatten
      end

      def script
        script   = "var formatter = new google.visualization.#{determine_google_class}("
        script  <<  collect_parameters
        script  << ");"

        @columns.each do |column|
         script << "formatter.format(chart_data, #{column});"
        end
        return script
      end

      def collect_parameters
        attributes = Array.new
        instance_variable_names.each do |instance_variable|
          next if instance_variable == "@columns"
          key         = instance_variable.gsub("@", "")
          value       = instance_variable_get(instance_variable)
          attribute   = key + ":" + (value.is_a?(String) ? "'" + value + "'" : value.to_s)
          attributes << attribute
        end
        return "{" + attributes.join(",") + "}"
      end
      
      protected
      
      def google_class
        return nil
      end
      
      private
      
      def determine_google_class
        return (google_class || self.class.to_s.split('::').last)
      end

    end
    
 end
end