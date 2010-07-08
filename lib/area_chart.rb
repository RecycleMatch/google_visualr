module GoogleVisualr

  # http://code.google.com/apis/visualization/documentation/gallery/areachart.html
  class AreaChart < BaseChart
    include GoogleVisualr::Packages::CoreChart
    # NOTE: attributes checked

    # http://code.google.com/apis/visualization/documentation/gallery/areachart.html#Configuration_Options
    # attr_accessor :axisColor
    # attr_accessor :axisBackgroundColor
    # attr_accessor :axisFontSize
    attr_accessor :backgroundColor
    # attr_accessor :borderColor
    attr_accessor :colors
    # attr_accessor :enableTooltip
    #attr_accessor :focusBorderColor
    attr_accessor :fontSize
    attr_accessor :hAxis
    attr_accessor :height
    attr_accessor :isStacked
    attr_accessor :legend
    # attr_accessor :legendBackgroundColor
    attr_accessor :legendFontSize
    attr_accessor :legendTextColor
    attr_accessor :lineWidth
    attr_accessor :pointSize
    attr_accessor :reverseCategories
    # attr_accessor :showCategories
    attr_accessor :title
    attr_accessor :titleColor
    attr_accessor :titleFontSize
    attr_accessor :tooltipFontSize
    # attr_accessor :tooltipHeight
    # attr_accessor :tooltipWidth
    attr_accessor :vAxis
    attr_accessor :width
    
  end

end