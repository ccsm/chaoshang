require 'spec_helper'

describe "dashboard/articles/show" do
  before(:each) do
    @dashboard_article = assign(:dashboard_article, stub_model(Dashboard::Article))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
