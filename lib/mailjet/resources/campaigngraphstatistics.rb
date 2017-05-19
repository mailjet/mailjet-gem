module Mailjet
  class Campaigngraphstatistics
    include Mailjet::Resource
    self.resource_path = 'REST/campaigngraphstatistics'
    self.public_operations =  [:get]
    self.filters = [:click, :ids, :open, :range, :spam, :unsub]
    self.resourceprop = [:click_count, :id, :opencount, :spamcount, :tick, :unsubcount]

  end
end
