module Mailjet
  class Batchjob
    include Mailjet::Resource
    self.resource_path = 'REST/batchjob'
    self.public_operations = [:get, :put, :post]
    self.filters = [:api_key, :data, :job_type, :max_job_end, :max_job_start, :max_request_at, :method, :min_job_end, :min_job_start, :min_request_at, :ref_id, :status]
    self.resourceprop = [:alive_at, :api_key, :blocksize, :count, :current, :data, :errcount, :err_treshold, :id, :job_end, :job_start, :job_type, :method, :ref_id, :request_at, :status, :throttle]

  end
end
