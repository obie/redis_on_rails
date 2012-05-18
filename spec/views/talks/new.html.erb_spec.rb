require 'spec_helper'

describe "talks/new" do
  before(:each) do
    assign(:talk, stub_model(Talk,
      :conference_id => 1
    ).as_new_record)
  end

  it "renders new talk form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => talks_path, :method => "post" do
      assert_select "input#talk_conference_id", :name => "talk[conference_id]"
    end
  end
end
