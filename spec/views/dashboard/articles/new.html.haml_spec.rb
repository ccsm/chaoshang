require 'spec_helper'

describe "dashboard/articles/new" do
  before(:each) do
    assign(:dashboard_article, stub_model(Dashboard::Article).as_new_record)
  end

  it "renders new dashboard_article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", dashboard_articles_path, "post" do
    end
  end
end
