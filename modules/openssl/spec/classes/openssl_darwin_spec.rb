require "spec_helper"

describe "openssl" do
  context "on Darwin" do
    let(:facts) do
      { :operatingsystem => 'Darwin' }
    end

    it { should include_class("openssl::install::darwin") }
  end
end
