module Mailjet
  class Axtesting
    include Mailjet::Resource
    self.resource_path = 'REST/axtesting'
    self.public_operations =  [:get, :put, :post, :delete]
    self.filters = [:contacts_list, :is_deleted, :segmentation]
    self.resourceprop = [:contact_list_id, :contact_list_alt, :created_at, :deleted, :id, :mode, :name, :percentage, :remainder_at, :segmentation_id, :segmentation_alt, :starred, :start_at, :status, :status_code, :status_string, :winner_click_rate, :winner_id, :winner_method, :winner_open_rate, :winner_spam_rate, :winner_unsub_rate]

  end
end
