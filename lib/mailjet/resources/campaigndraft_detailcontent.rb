module Mailjet
  class Campaigndraft_detailcontent
    include Mailjet::Resource
    self.action = "detailcontent"
    self.resource_path = "REST/campaigndraft/id/#{self.action}"
    self.public_operations = [:get, :post]
    self.filters = []
    self.resourceprop = [:text_part, :html_part, :headers, :mjml_content]

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
