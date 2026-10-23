module Mailjet
  class Campaigngraphstatistics
    include Mailjet::Resource
    self.resource_path = 'REST/campaigngraphstatistics'
    self.public_operations =  [:get]
    self.replaced_by = 'Mailjet::Statcounters with counter_source: "Campaign"'
    self.filters = [:click, :ids, :open, :range, :spam, :unsub]
    self.resourceprop = [:click_count, :id, :opencount, :spamcount, :tick, :unsubcount]

  end
end
