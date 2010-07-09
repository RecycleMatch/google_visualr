module GoogleVisualr

  class BaseChart

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
    #
    ##############################
    # Syntax Description of Data Object
    ##############################
    #
    # The data object consists of two required top-level properties, cols and rows.
    #
    # * cols property
    #
    #   cols is an array of objects describing the ID and type of each column. Each property is an object with the following properties (case-sensitive):
    #
    #   * type            [Required] The data type of the data in the column. Supports the following string values:
    #     - 'string'    : String value. Example values: v:'foo', v:'bar'
    #     - 'number'    : Number value. Example values: v:7, v:3.14, v:-55
    #     - 'boolean'   : Boolean value ('true' or 'false'). Example values: v:true, v:false
    #     - 'date'      : Date object, with the time truncated. Example value: v:Date.parse('2010-01-01')
    #     - 'datetime'  : DateTime/Time object, time inclusive. Example value: v:DateTime.parse('2010-01-01 14:20:25')
    #     - 'timeofday' : Array of 3 numbers or 4 numbers, [Hour,Minute,Second,(Optional) Milliseconds]. Example value: v:[8, 15, 0]
    #   * label           [Optional] A string value that some visualizations display for this column. Example: label:'Height'
    #   * id              [Optional] A unique (basic alphanumeric) string ID of the column. Be careful not to choose a JavaScript keyword. Example: id:'col_1'
    #
    # * rows property
    #
    #   The rows property holds an array of row objects. Each row object has one required property called c, which is an array of cells in that row.
    #
    #   Each cell in the table is described by an object with the following properties:
    #
    #   * v               [Optional] The cell value. The data type should match the column data type.
    #   * f               [Optional] A string version of the v value, formatted strictly for display only. If omitted, a string version of v will be used.
    #
    #   Cells in the row array should be in the same order as their column descriptions in cols.
    #
    #   To indicate a null cell, you can either specify null, or set empty string for a cell in an array, or omit trailing array members.
    #   So, to indicate a row with null for the first two cells, you could specify [ '', '', {cell_val}] or [null, null, {cell_val}].
    def initialize(options = {})

      @data_table = GoogleVisualr::DataTable::DataTable.new

      unless options.empty?
        cols = options[:cols]
        @data_table.add_columns(cols)

        rows = options[:rows]
        rows.each do |row|
          @data_table.add_row(row[:c])
        end
      end

    end
    
    # DATA TABLE
    
    def add_column(type, label = '', id = '')
      @data_table.add_column (type, label, id)
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
        
    protected
    
    # Defines a concrete google api package name
    def google_package
      return nil
    end
    
    # Defines a concrete google api class name
    def google_class
      return nil
    end
    
    private
    
    # Determines the google api package name
    def determine_google_package
      return (google_package || self.class.to_s.split('::').last.downcase)
    end

    # Determines the google api class name
    def determine_google_class
      return (google_class || self.class.to_s.split('::').last)
    end

    # determines defined instance variables of child class
    def determine_parameters

      attributes = Array.new

      variables  = instance_variable_names
      variables.delete("@data_table")
      variables.delete("@formatters")      
      
      variables.each do |instance_variable|
        key         = instance_variable.gsub("@", "")
        value       = instance_variable_get(instance_variable)
        attribute   = "#{key}:#{GoogleVisualr::DataTable::Typecasting.typecast(value)}"
        attributes << attribute
      end

      return "{" + attributes.join(",") + "}"

    end

#   def add_row_cell(cell)
#
#      if cell.is_a?(Hash)
#
#        attributes = Array.new
#        cell.each_pair do |key, value|
#          attributes << "#{key}: #{GoogleVisualr::DataTable::Typecasting.typecast(value)}"
#        end
#
#        return "{" + attributes.join(",") + "}"
#
#      else
#        return "#{GoogleVisualr::DataTable::Typecasting.typecast(cell)}"
#      end
#
#    end

  end

end