require "spec_helper"

describe "libyaml" do
  it do
    should contain_autotools("libyaml").with_environment({})
  end
end
