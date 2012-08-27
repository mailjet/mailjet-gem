require 'mailjet/api'
require 'mailjet/list'
require 'mailjet/contact'

module Mailjet
  class Campaign < OpenStruct

    def update(options = {})
      (options.delete(:api) || Mailjet::Api.singleton).messageUpdatecampaign(options.reverse_merge(:id => self.id), 'Post')["status"]
    end

    def contacts(options = {})
      ((options.delete(:api) || Mailjet::Api.singleton).messageContacts(options.reverse_merge(:id => self.stats_campaign_id))["result"] || []).map do |contact|
        Mailjet::Contact.new(contact)
      end
    end

    def send!(options = {})
      (options.delete(:api) || Mailjet::Api.singleton).messageSendcampaign(options.reverse_merge(:id => self.id), 'Post')["status"]
    end

    def test(*params)
      options = params.last.is_a?(Hash) ? params.pop : {}
      email = params.first
      (options.delete(:api) || Mailjet::Api.singleton).messageTestcampaign(options.reverse_merge(:id => self.id, :email => email), 'Post')["status"]
    end

    def statistics(options = {})
      (options.delete(:api) || Mailjet::Api.singleton).messageStatistics(options.reverse_merge(:id => self.stats_campaign_id))["result"]
    end

    def html(options = {})
      (options.delete(:api) || Mailjet::Api.singleton).messageHtmlcampaign(options.reverse_merge(:id => self.id))["html"]
    end

    def duplicate(options = {})
      new_id = (options.delete(:api) || Mailjet::Api.singleton).messageDuplicatecampaign(options.reverse_merge(:id => self.id), 'Post')['new_id']
      self.class.new(:id => new_id)
    end

    class << self
      def create(options = {})
        campaign_attr = (options.delete(:api) || Mailjet::Api.singleton).messageCreatecampaign(options, 'Post')["campaign"]
        campaign = find(campaign_attr["id"]).tap{ |c| campaign_attr.each{ |k, v| c.send("#{k}=", v) } }
        puts campaign.inspect
        campaign
      end

      def all(options = {})
        (options.delete(:api) || Mailjet::Api.singleton).messageCampaigns(options)["result"].map do |result_hash|
          self.new(result_hash)
        end
      end

      def find(*params)
        options = params.last.is_a?(Hash) ? params.pop : {}
        ids = params.flatten.map(&:to_s).reject(&:blank?)
        self.all(options).find{|c| ids.include?(c.id.to_s)}
      end
    end
  end
end
