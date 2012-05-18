require 'spec_helper'

describe "tutorials/edit" do
  before(:each) do
    @tutorial = assign(:tutorial, stub_model(Tutorial,
      :conference_id => 1
    ))
  end

  it "renders the edit tutorial form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tutorials_path(@tutorial), :method => "post" do
      assert_select "input#tutorial_conference_id", :name => "tutorial[conference_id]"
    end
  end
end
