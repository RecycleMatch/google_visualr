module GoogleVisualr

  # http://code.google.com/apis/visualization/documentation/gallery/columnchart.html
  class ColumnChart < BaseChart
    # NOTE: attributes checked

    attr_accessor :element_id

    # http://code.google.com/apis/visualization/documentation/gallery/columnchart.html#Configuration_Options
    # attr_accessor :axisColor
    # attr_accessor :axisBackgroundColor
    # attr_accessor :axisFontSize
    attr_accessor :backgroundColor
    # attr_accessor :borderColor
    attr_accessor :colors
    attr_accessor :fontSize
    # attr_accessor :enableTooltip
    # attr_accessor :focusBorderColor
    attr_accessor :hAxis
    attr_accessor :height
    # attr_accessor :is3D
    attr_accessor :isStacked
    attr_accessor :legend
    # attr_accessor :legendBackgroundColor
    attr_accessor :legendFontSize
    attr_accessor :legendTextColor
    attr_accessor :reverseCateogories
    # attr_accessor :showCategories
    attr_accessor :title
    attr_accessor :titleColor
    attr_accessor :titleFontSize
    attr_accessor :tooltipFontSize
    # attr_accessor :tooltipHeight
    # attr_accessor :tooltipWidth
    attr_accessor :vAxis
    attr_accessor :width

    def render (element_id)

      options = Hash.new

      options[:element_id]  = element_id
      options[:chart_style] = collect_parameters

      super(options)

    end
    
    protected
    
    def google_package
      return "corechart"
    end
    
  end

end