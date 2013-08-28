require 'spec_helper'

describe "dashboard/articles/index" do
  before(:each) do
    assign(:dashboard_articles, [
      stub_model(Dashboard::Article),
      stub_model(Dashboard::Article)
    ])
  end

  it "renders a list of dashboard/articles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
