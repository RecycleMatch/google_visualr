module GoogleVisualr
  module DataTable
    
    require File.dirname(__FILE__) + '/data_table/data_column'
    require File.dirname(__FILE__) + '/data_table/data_row'
    require File.dirname(__FILE__) + '/data_table/data_cell'
    
    class DataTable
    
      attr_accessor :cols
      attr_accessor :rows
      attr_accessor :cells
    
      def initialize
        @cols  = Array.new
        @rows  = Array.new
        @cells = Array.new
      end
    
      # Adds a new column to the visualization.
      #
      # Parameters:
      #   * type            [Required] The data type of the data in the column. Supports the following string values:
      #     - 'string'    : String value. Example values: v:'hello'
      #     - 'number'    : Number value. Example values: v:7 , v:3.14, v:-55
      #     - 'date'      : Date object, with the time truncated. Example values: v:Date.parse('2010-01-01')
      #     - 'datetime'  : Date object including the time. Example values: v:Date.parse('2010-01-01 14:20:25')
      #     - 'boolean'   : Boolean value ('true' or 'false'). Example values: v: true
      #   * label           [Optional] A string value that some visualizations display for this column. Example: label:'Height'
      #   * id              [Optional] A unique (basic alphanumeric) string ID of the column. Be careful not to choose a JavaScript keyword. Example: id:'col_1'
      def add_column (type, label = '', id = '')
        @cols << GoogleVisualr::DataTable::DataColumn.new(type, label, id)
      end

      # Adds multiple columns to the visualization.
      #
      # Parameters:
      #   * columns         [Required] An array of column objects {:type, :label, :id}. Calls add_column for each column object.
      def add_columns(columns = Array.new)
        columns.each do |column|
          add_column(column[:type], column[:label], column[:id])
        end
      end

      # Adds a new row to the visualization.
      # Call method without any parameters to add an empty row, otherwise, call method with a row object.
      #
      # Parameters:
      #   * row             [Optional] An array of cell values specifying the data for the new row.
      #     - You can specify a value for a cell (e.g. 'hi') or specify a formatted value using cell objects (e.g. {v:55, f:'Fifty-five'}) as described in the constructor section.
      #     - You can mix simple values and cell objects in the same method call.
      #     - To create an empty cell, use nil or empty string.
      def add_row(row = nil)

        #if row.blank?
        #  @rows << GoogleVisualr::DataTable::DataRow.new([''])
        #else
          @rows << GoogleVisualr::DataTable::DataRow.new(row)
        #end

      end

      # Adds multiple rows to the visualization. You can call this method with data to populate a set of new rows or create new empty rows.
      #
      # Parameters:
      #   * array_or_num    [Required] Either an array or a number.
      #     - Array: An array of row objects used to populate a set of new rows. Each row is an object as described in add_row().
      #     - Number: A number specifying the number of new empty rows to create.
      def add_rows(array_or_num)

        if array_or_num.is_a?(Array)
          array_or_num.each do |row|
            add_row(row)
          end
        else
          add_row(array_or_num)
        end

      end

      # Sets the value and/or formatted value of a cell.
      #
      # Parameters:
      #   * row_index       [Required] A number greater than or equal to zero, but smaller than the total number of rows.
      #   * column_index    [Required] A number greater than or equal to zero, but smaller than the total number of columns.
      #   * value           [Required] The cell value. The data type should match the column data type.
      #   * formatted_value [Optional] A string version of value, formatted strictly for display only. If omitted, a string version of value will be used.
      def set_cell(row_index, column_index, value, formatted_value=nil, properties=nil)
        @cells << GoogleVisualr::DataTable::DataCell.new(row_index, column_index, value, formatted_value, properties)
      end

      # Sets the value of a cell. Overwrites any existing cell value, and clear out any formatted value for the cell.
      #
      # Parameters:
      #   * row_index       [Required] A number greater than or equal to zero, but smaller than the total number of rows.
      #   * column_index    [Required] A number greater than or equal to zero, but smaller than the total number of columns.
      #   * value           [Required] The cell value. The data type should match the column data type.
      def set_value(row_index, column_index, value)
        @cells << GoogleVisualr::DataTable::DataCell.new(row_index, column_index, value)
      end
    
    
      def render
        res = "var chart_data = new google.visualization.DataTable();"
        
        @cols.each do |column|
          res << " #{column.render}"
        end
        
        @rows.each do |row|
          res << " #{row.render}"
        end
        
        @cells.each do |cell|
          res << " #{cell.render}"
        end
        
        return res
      end
    
    end
  end
end