require 'minitest_helper'

describe Mailjet::TemplateModel do
  it 'has an integration suite, tested directly against Mailjet service' do
    
    # Mailjet::TemplateModel.all
    models = Mailjet::TemplateModel.all
    models.wont_be_empty
    model = models.find{|t| t.id == '4'} # from default Mailjet templates
    model.must_be_instance_of Mailjet::TemplateModel
    model.name == "Text"
  end
end
