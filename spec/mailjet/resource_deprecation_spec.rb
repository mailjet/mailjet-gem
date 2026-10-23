require "mailjet_spec_helper"

RSpec.describe Mailjet::Resource, "deprecation warnings" do
  let(:deprecated_resource) do
    stub_const("DeprecatedTestResource", Class.new do
      include Mailjet::Resource
      self.resource_path = "REST/deprecatedtest"
      self.replaced_by = "Mailjet::Statcounters"
    end)
  end

  let(:current_resource) do
    stub_const("CurrentTestResource", Class.new do
      include Mailjet::Resource
      self.resource_path = "REST/currenttest"
    end)
  end

  it "warns once, on first use, naming the replacement" do
    expect(Kernel).to receive(:warn)
      .with("[mailjet] DeprecatedTestResource is deprecated and will be removed in 2.0.0. Use Mailjet::Statcounters instead.")
      .once

    2.times { deprecated_resource.connection(deprecated_resource.define_options) }
  end

  it "does not warn for resources that are not deprecated" do
    expect(Kernel).not_to receive(:warn)

    current_resource.connection(current_resource.define_options)
  end

  it "names an existing replacement for each of the 15 deprecated resources" do
    deprecated = Mailjet.constants
      .map { |name| Mailjet.const_get(name) }
      .select { |klass| klass.is_a?(Class) && klass.include?(Mailjet::Resource) && klass.replaced_by }

    expect(deprecated.size).to eq 15
    deprecated.each do |klass|
      replacement = klass.replaced_by[/\AMailjet::(\w+)/, 1]
      expect(Mailjet.const_defined?(replacement)).to be(true), "#{klass} names missing Mailjet::#{replacement}"
    end
  end
end
