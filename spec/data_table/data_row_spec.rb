require File.expand_path(File.join(File.dirname(__FILE__),'..', 'spec_helper'))
require 'csv'

module GoogleVisualr
  module DataTable
    describe DataTable do
      before(:each) do
      end
      
      it "should accept an array for initialization" do
        row = DataRow.new [0, 1, 2]
        row.data.should be_a_kind_of(Array)
      end
      
      it "should accept a hash for initialization" do
        row = DataRow.new ({ :v => 8, :f => "eight" })
        row.data.should be_a_kind_of(Hash)
      end
      
      it "should render a hash" do
        row = DataRow.new ({ :v => 8, :f => "eight" })
        row.render.should eql("chart_data.addRows( [ [{v: 8, f: 'eight'}] ] );")
      end
      
      describe "#to_csv" do
        it "should render parseable csv" do
          data = DataTable.new()
          data.add_column("string", "Column 1")
          data.add_column("string", "Column 2")
          data.add_row(["hello", "world"])
          data.add_row(["goodbye", "lunch"])
          CSV.parse(data.to_csv).should == [["Column 1", "Column 2"],["hello", "world"],["goodbye", "lunch"]]
          
        end
      end
      
    end
  end
end
