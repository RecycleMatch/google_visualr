module GoogleVisualr
  module Utilities
    module AttributeReflection
      
      private
      
      def get_attributes_except(rejected_attributes = [])
        
        variables = instance_variable_names
        
        rejected_attributes.each do |rejected_attribute|
          variables.delete(rejected_attribute)
        end
        
        return variables
        
      end
      
    end
  end
end