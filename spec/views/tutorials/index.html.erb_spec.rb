require 'spec_helper'

describe "tutorials/index" do
  before(:each) do
    assign(:tutorials, [
      stub_model(Tutorial,
        :conference_id => 1
      ),
      stub_model(Tutorial,
        :conference_id => 1
      )
    ])
  end

  it "renders a list of tutorials" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
