module Mailjet
  class Newslettertemplatecategory
    include Mailjet::Resource
    self.resource_path = 'REST/newslettertemplatecategory'
    self.public_operations = [:get]
    self.filters = [:locale]
    self.resourceprop = [:description, :id, :locale, :parent_category, :value]

  end
end
