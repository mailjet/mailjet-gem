require 'mailjet/resource'

module Mailjet
  class Csvimport
    include Mailjet::Resource
    self.resource_path = 'v3/REST/csvimport'
    self.public_operations = [:get, :put, :post]
    self.filters = []
    self.properties = [:alive_at, :contacts_list, :count, :current, :data_id, :errcount, :err_treshold, :id, :import_options, :job_end, :job_start, :method, :request_at, :status]

  end
end
