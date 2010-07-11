module GoogleVisualr
  module Formatters
  
    class BaseFormat
      include GoogleVisualr::Utilities::GoogleClassReflection

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
        script  <<  determine_parameters
        script  << ");"

        @columns.each do |column|
         script << "formatter.format(chart_data, #{column});"
        end
        return script
      end
            
      private
            
      # determines defined instance variables of child class
      def determine_parameters
        attributes = Array.new

        variables  = instance_variable_names
        variables.delete("@columns")

        variables.each do |instance_variable|
          key         = instance_variable.gsub("@", "")
          value       = instance_variable_get(instance_variable)
          attribute   = key + ":" + (value.is_a?(String) ? "'" + value + "'" : value.to_s)
          attributes << attribute
        end

        return "{" + attributes.join(",") + "}"
      end
      
    end
    
 end
end