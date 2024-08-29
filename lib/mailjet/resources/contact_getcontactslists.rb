module Mailjet
  class Contact_getcontactslists
    include Mailjet::Resource
    self.action = "getcontactslists"
    self.resource_path = "REST/contact/id/#{self.action}"
    self.public_operations = [:get]
    self.filters = []
    self.resourceprop = []

    def self.find(id, job_id = nil, options = {})
      opts = define_options(options)
      self.resource_path = create_action_resource_path(id, job_id) if self.action

      raw_data = parse_api_json(connection(opts).get(default_headers).body)

      raw_data.map do |entity|
        instanciate_from_api(entity)
      end
    rescue Mailjet::CommunicationError => e
      if e.code == 404
        nil
      else
        raise e
      end
    end
  end
end
