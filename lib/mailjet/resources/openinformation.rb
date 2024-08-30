module Mailjet
  class Openinformation
    include Mailjet::Resource
    self.resource_path = 'REST/openinformation'
    self.public_operations = [:get]
    self.filters = [:campaign_id, :campaign_status, :contacts_list, :custom_campaign, :from, :from_domain, :from_id, :from_ts, :from_type, :is_deleted, :is_newsletter_tool, :is_starred, :message_status, :period, :to_ts]
    self.resourceprop = [:arrived_at, :campaign, :contact, :id, :message_id, :opened_at, :user_agent, :user_agent_full]

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
