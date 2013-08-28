require 'spec_helper'

describe "dashboard/articles/edit" do
  before(:each) do
    @dashboard_article = assign(:dashboard_article, stub_model(Dashboard::Article))
  end

  it "renders the edit dashboard_article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", dashboard_article_path(@dashboard_article), "post" do
    end
  end
end
