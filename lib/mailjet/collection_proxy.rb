module Mailjet
  class CollectionProxy
    attr_accessor :count

    def intialize(response = {})
      self.count = response['Total']
      @proxy = response['Data'] ? Array.new(response['Data']) : []
    end

    def method_missing(name, *args, &block)
      @proxy.send(name, *args, &block)
    end

  end
end
