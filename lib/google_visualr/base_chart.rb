module GoogleVisualr

  class BaseChart
    include GoogleVisualr::Utilities::AttributeReflection
    include GoogleVisualr::Utilities::GooglePackageReflection
    include GoogleVisualr::Utilities::GoogleClassReflection

    attr_accessor :data_table
    attr_accessor :formatters

    ##############################
    # Constructors
    ##############################
    #
    # GoogleVisualr::visualization.new:
    # Creates an empty visualization instance. Use add_columns, add_rows and set_value or set_cell methods to populate the visualization.
    #
    # GoogleVisualr::visualization.new(data object):
    # Creates a visualization by passing a JavaScript-string-literal like data object into the data parameter. This object can contain formatting options.
    
    def initialize(options = {})
      @data_table = GoogleVisualr::DataTable::DataTable.new(options)
    end
    
    # DATA TABLE HELPERS
    
    def add_column(type, label = '', id = '')
      @data_table.add_column(type, label, id)
    end
    
    def add_columns(columns)
      @data_table.add_columns(columns)
    end
    
    def add_row(row)
      @data_table.add_row(row)
    end
    
    def add_rows(array_or_num)
      @data_table.add_rows(array_or_num)
    end
    
    def set_cell(row_index, column_index, value, formatted_value = nil, properties = nil)
      @data_table.set_cell(row_index, column_index, value, formatted_value = nil, properties = nil)
    end
    
    def set_value(row_index, column_index, value)
      @data_table.set_value(row_index, column_index, value)
    end
    
    ### FORMAT

    # Applies one or more formatters to the visualization to format the columns as specified by the formatter/s.
    #
    # Parameters:
    #   * formatter/s     [Required] One, or an array of formatters.
    def format(*formatters)
      @formatters ||= Array.new
      @formatters  += formatters
    end
    
    ### OPTIONS

    # Sets chart configuration options with a hash.
    #
    # Parameters:
    #  *options            [Required] A hash of configuration options.
    def set_options(options)
      options.each_pair do | key, value |
        send "#{key}=", value
      end
    end
    
    ### RENDER

    # Generates JavaScript and renders the visualization in the final HTML output.
    #
    # Parameters:
    #  *div_id            [Required] The ID of the DIV element that the visualization should be rendered in.
    #
    # Note: This is the super method.    
    def render(element_id)
      return render_script_tag(render_javascript_code(element_id))
    end
    
    def render_javascript_code(element_id)
      code = "\n    google.load('visualization','1', {packages: ['#{determine_google_package}'], callback: function() {"
      code << "\n      #{@data_table.render}"
      if @formatters
        @formatters.each do |formatter|
          code << formatter.script
        end
      end
      code << "\n      var chart = new google.visualization.#{determine_google_class}(document.getElementById('#{element_id}'));"
      code << "\n      chart.draw(chart_data, #{determine_parameters});"
      
      return code
    end
    
    def render_script_tag(code)
      script  = "\n<script type='text/javascript'>"
      script << "\n  //<![CDATA["
      script << "\n    #{code}"
      script << "\n    }});"
      script << "\n  //]]>"
      script << "\n</script>"
      
      return script
    end
        
    private

    # determines defined instance variables of child class
    def determine_parameters
      
      parameters = Array.new
      attributes = get_attributes_except(["@data_table", "@formatters"])
      
      attributes.each do |attribute|
        key         = attribute.gsub("@", "")
        value       = instance_variable_get(attribute)
        parameter   = "#{key}:#{GoogleVisualr::Utilities::TypeConversion.convert(value)}"
        parameters << parameter
      end
      
      return "{" + parameters.join(",") + "}"
    end

#   def add_row_cell(cell)
#
#      if cell.is_a?(Hash)
#
#        attributes = Array.new
#        cell.each_pair do |key, value|
#          attributes << "#{key}: #{GoogleVisualr::Utilities::TypeConversion.convert(value)}"
#        end
#
#        return "{" + attributes.join(",") + "}"
#
#      else
#        return "#{GoogleVisualr::Utilities::TypeConversion.convert(cell)}"
#      end
#
#    end

  end

end