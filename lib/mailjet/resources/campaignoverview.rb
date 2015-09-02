require 'mailjet/resource'

module Mailjet
  class Campaignoverview
    include Mailjet::Resource
    self.resource_path = 'v3/REST/campaignoverview'
    self.public_operations =  [:get]
    self.filters = [:archived, :drafts, :programmed, :sent, :starred, :subject]
    self.properties = [:titled, :subject, :status, :starred, :sent_time_start, :processed_count, :opened_count, :id_type, :id, :edit_type, :edit_mode, :clicked_count]

  end
end
