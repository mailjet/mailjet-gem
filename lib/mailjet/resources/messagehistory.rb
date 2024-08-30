module Mailjet
  class Messagehistory
    include Mailjet::Resource
    self.resource_path = 'REST/messagehistory'
    self.public_operations = [:get]
    self.filters = [:message]
    self.resourceprop = [:event_at, :event_type, :useragent]

    self.read_only = true

    def self.find(id, job_id = nil, options = {})
      opts = define_options(options)
      self.resource_path = create_action_resource_path(id, job_id) if self.action

      raw_data = parse_api_json(connection(opts)[id].get(default_headers).body)

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
