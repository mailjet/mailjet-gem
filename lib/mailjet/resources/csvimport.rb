module Mailjet
  class Csvimport
    include Mailjet::Resource
    self.resource_path = 'REST/csvimport'
    self.public_operations = [:get, :put, :post]
    self.filters = []
    self.resourceprop = [:alive_at, :contacts_list, :count, :current, :data_id, :errcount, :err_treshold, :id, :import_options, :job_end, :job_start, :method, :request_at, :status]

  end
end
