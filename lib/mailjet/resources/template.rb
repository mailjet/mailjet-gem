module Mailjet
  class Template
    include Mailjet::Resource
    self.resource_path = 'REST/template'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:api_key, :categories, :categories_selection_method, :edit_mode, :name, :owner_type, :purposes, :purposes_selection_method, :user]
    self.resourceprop = [:author, :categories, :copyright, :description, :edit_mode, :is_starred, :name, :owner_type, :presets, :purposes]

  end
end
