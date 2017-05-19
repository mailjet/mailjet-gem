module Mailjet
  class Campaign
    include Mailjet::Resource
    self.resource_path = 'REST/campaign'
    self.public_operations = [:get, :put]
    self.filters = [:campaign_id, :campaign_status, :contacts_list, :custom_campaign, :from, :from_domain, :from_id, :from_ts, :from_type, :is_deleted, :is_newsletter_tool, :is_starred, :period, :to_ts]
    self.resourceprop = [:campaign_type, :click_tracked, :created_at, :custom_value, :first_message_id, :from, :from_email, :from_name, :has_html_count, :has_txt_count, :id, :is_deleted, :is_starred, :list, :news_letter_id, :open_tracked, :segmentation, :send_end_at, :send_start_at, :spamass_score, :status, :subject, :unsubscribe_tracked_count]

  end
end
