module Mailjet
  class Newsletterblock
    include Mailjet::Resource
    self.resource_path = 'REST/newsletterblock'
    self.public_operations = [:get, :put, :post, :delete]
    self.filters = [:news_letter]
    self.resourceprop = [:align, :alt, :block_type, :color, :content, :filename, :fontfamily, :fontsize, :id, :line, :link, :news_letter, :pos, :siblings, :src_height, :src_width, :url, :width]

  end
end
