require 'mailjet/resource'

module Mailjet
  class Newslettertemplateblock
    include Mailjet::Resource
    self.resource_path = 'v3/REST/newslettertemplateblock'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:news_letter_template]
    self.properties = [:align, :alt, :block_type, :color, :content, :filename, :fontfamily, :fontsize, :id, :line, :link, :pos, :siblings, :src_height, :src_width, :template, :url, :width]

  end
end
