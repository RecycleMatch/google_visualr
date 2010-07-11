module GoogleVisualr
  module Visualizations

    class PieChart < BaseChart
      include GoogleVisualr::Packages::CoreChart
      
      # google reference:
      # http://code.google.com/apis/visualization/documentation/gallery/piechart.html

      attr_accessor :backgroundColor
      attr_accessor :colors
      attr_accessor :fontSize
      attr_accessor :height
      attr_accessor :legend
      attr_accessor :legendFontSize
      attr_accessor :legendTextColor
      attr_accessor :reverseCategories
      attr_accessor :title
      attr_accessor :titleColor
      attr_accessor :titleFontSize
      attr_accessor :tooltipFontSize
      attr_accessor :width

    end

  end
end