require 'spec_helper'

describe "tutorials/new" do
  before(:each) do
    assign(:tutorial, stub_model(Tutorial,
      :conference_id => 1
    ).as_new_record)
  end

  it "renders new tutorial form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tutorials_path, :method => "post" do
      assert_select "input#tutorial_conference_id", :name => "tutorial[conference_id]"
    end
  end
end
