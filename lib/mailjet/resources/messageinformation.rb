module Mailjet
  class Messageinformation
    include Mailjet::Resource
    self.resource_path = 'REST/messageinformation'
    self.public_operations = [:get]
    self.filters = [:campaign_id, :campaign_status, :contacts_list, :custom_campaign, :from, :from_domain, :from_id, :from_ts, :from_type, :is_deleted, :is_newsletter_tool, :is_starred, :message_status, :period, :to_ts]
    self.resourceprop = [:campaign, :click_tracked_count, :contact, :created_at, :id, :message_size, :open_tracked_count, :queued_count, :send_end_at, :sent_count, :spam_assassin_rules, :spam_assassin_score]

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
