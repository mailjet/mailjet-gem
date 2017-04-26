module Mailjet
  class Campaigndraft
    include Mailjet::Resource
    self.resource_path = 'v3/REST/campaigndraft'
    self.public_operations = [:get, :put, :post]
    self.filters = [:campaign, :contacts_list, :delivered_at, :edit_mode, :is_archived, :is_campaign, :is_deleted, :is_handled, :is_starred, :modified, :news_letter_template, :segmentation, :status, :subject, :template]
    self.resourceprop = [:campaign, :contacts_list, :created_at, :delivered_at, :edit_mode, :id, :is_starred, :is_text_part_included, :locale, :modified_at, :preset, :reply_email, :segmentation, :sender, :sender_email, :sender_name, :status, :subject, :template_id, :title, :url, :used, 'CampaignID', 'CampaignALT', 'ContactsListID', 'ContactsListALT', 'SegmentationID', 'SegmentationALT', :contacts_list_id,'TemplateID']

  end
end
