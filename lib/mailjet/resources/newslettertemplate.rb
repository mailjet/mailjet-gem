module Mailjet
  class Newslettertemplate
    include Mailjet::Resource
    self.resource_path = 'REST/newslettertemplate'
    self.public_operations = [:get, :put, :post]
    self.filters = [:is_public, :news_letter_template_category]
    self.resourceprop = [:category, :created_at, :footer, :footer_address, :footer_wysiwyg_type, :header_filename, :header_link, :header_text, :header_url, :id, :locale, :name, :permalink, :permalink_wysiwyg_type, :source_news_letter_id, :status]

  end
end
