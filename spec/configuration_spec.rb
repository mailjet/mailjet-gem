require "mailjet_spec_helper"

RSpec.describe Mailjet::Configuration do
  def reset_config
    Mailjet.send(:remove_const, :Configuration) if Mailjet.const_defined?(:Configuration)
    load "mailjet/configuration.rb"
  end

  before(:each) do
    reset_config
  end

  after(:all) do
    reset_config
  end

  it "sets default configuration settings" do
    expect(Mailjet.config.api_version).to eq "v3"
    expect(Mailjet.config.sandbox_mode).to eq false
    expect(Mailjet.config.end_point).to eq "https://api.mailjet.com"
    expect(Mailjet.config.perform_api_call).to eq true
  end

  it "overrides default configuration settings" do
    Mailjet.configure do |config|
      config.api_version = "new version"
      config.sandbox_mode = true
      config.end_point = "custom endpoint"
      config.perform_api_call = false
    end

    expect(Mailjet.config.api_version).to eq "new version"
    expect(Mailjet.config.sandbox_mode).to eq true
    expect(Mailjet.config.end_point).to eq "custom endpoint"
    expect(Mailjet.config.perform_api_call).to eq false
  end
end
