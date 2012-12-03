require "spec_helper"

describe "ruby" do
  it do
    should_not contain_autotools("ruby").
      with_configure_flags(/ --with-arch=x86_64,i386/)
  end
end
