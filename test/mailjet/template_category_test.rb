require 'minitest_helper'

describe Mailjet::TemplateCategory do
  it 'has an integration suite, tested directly against Mailjet service' do
    
    # Mailjet::TemplateCategory.all
    models = Mailjet::TemplateCategory.all
    models.wont_be_empty
    model = models.find{|m| m.id == "2"} # from default Mailjet templates
    model.must_be_instance_of Mailjet::TemplateCategory
    model.label.must_equal "basic"
  end
end
