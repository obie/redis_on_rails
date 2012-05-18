require 'spec_helper'

describe "talks/edit" do
  before(:each) do
    @talk = assign(:talk, stub_model(Talk,
      :conference_id => 1
    ))
  end

  it "renders the edit talk form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => talks_path(@talk), :method => "post" do
      assert_select "input#talk_conference_id", :name => "talk[conference_id]"
    end
  end
end
