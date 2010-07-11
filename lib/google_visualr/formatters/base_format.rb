module GoogleVisualr
  module Formatters
  
    class BaseFormat
      include GoogleVisualr::Utilities::GoogleAttributeReflection
      include GoogleVisualr::Utilities::GoogleClassReflection

      # google reference:
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
        script  <<  determine_google_parameters
        script  << ");"

        @columns.each do |column|
         script << "formatter.format(chart_data, #{columns});"
        end
        return script
      end
            
      private
            
      # determines defined instance variables of child class
      def determine_google_parameters
        return determine_google_attriutes(["@columns"])
        
#        parameters = Array.new
#        attributes  = get_attributes_except(["@columns"])

#        attributes.each do |attribute|
#          key         = attribute.gsub("@", "")
#          value       = instance_variable_get(attribute)
#          parameter   = key + ":" + (value.is_a?(String) ? "'" + value + "'" : value.to_s)
#          parameters << parameter
#        end
#
#        return "{" + parameters.join(",") + "}"
      end
      
    end
    
 end
end