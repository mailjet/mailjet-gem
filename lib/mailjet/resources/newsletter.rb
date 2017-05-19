module Mailjet
  class Newsletter
    include Mailjet::Resource
    self.resource_path = 'REST/newsletter'
    self.public_operations = [:get, :put, :post]
    self.filters = [:campaign, :contacts_list, :delivered_at, :edit_mode, :is_archived, :is_campaign, :is_deleted, :is_handled, :is_starred, :modified, :news_letter_template, :segmentation, :status, :subject]
    self.resourceprop = [:callback, :campaign, :contacts_list, :created_at, :delivered_at, :edit_mode, :edit_type, :footer, :footer_address, :footer_wysiwyg_type, :header_filename, :header_link, :header_text, :header_url, :id, :ip, :is_handled, :is_starred, :is_text_part_included, :locale, :modified_at, :permalink, :permalink_host, :permalink_wysiwyg_type, :politeness_mode, :reply_email, :segmentation, :sender, :sender_email, :sender_name, :status, :subject, :template, :test_address, :title, :url, 'CampaignID', 'CampaignALT', 'ContactsListID', 'ContactsListALT', 'SegmentationID', 'SegmentationALT', :contacts_list_id]

  end
end
