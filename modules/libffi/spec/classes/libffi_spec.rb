require "spec_helper"

describe "libffi" do
  it "should call autotools with empty environment" do
    should contain_autotools("libffi").with_environment({})
  end
end
