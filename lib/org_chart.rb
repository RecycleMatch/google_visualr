module GoogleVisualr

  # http://code.google.com/apis/visualization/documentation/gallery/orgchart.html
  class OrgChart < BaseChart
    # NOTE: attributes checked

    # http://code.google.com/apis/visualization/documentation/gallery/orgchart.html#Configuration_Options
    attr_accessor :allowCollapse
    attr_accessor :allowHtml
    attr_accessor :nodeClass
    attr_accessor :selectedNodeClass
    attr_accessor :size

  end

end