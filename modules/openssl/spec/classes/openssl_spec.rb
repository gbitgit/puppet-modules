require "spec_helper"

describe "openssl" do
  it { should include_class("openssl::install::linux") }
end
