require 'mailjet/api'
require 'mailjet/click'

module Mailjet
  class Reporting
    class << self
      def clicks(options = {})
        ((options.delete(:api) || Mailjet::Api.singleton).reportClick(options)["clicks"] || []).map do |click|
          Mailjet::Click.new(click)
        end
      end

      def domains(options = {})
        (options.delete(:api) || Mailjet::Api.singleton).reportDomain(options)["domains"] || []
      end

      def clients(options = {})
        (options.delete(:api) || Mailjet::Api.singleton).reportEmailclients(options)["email_clients"] || []
      end

      def emails(options = {})
        ((options.delete(:api) || Mailjet::Api.singleton).reportEmailsent(options)["emails"] || []).map do |email|
          Mailjet::Email.new(email)
        end
      end

      def bounce(options = {})
        (options.delete(:api) || Mailjet::Api.singleton).reportEmailbounce(options)["bounces"] || []
      end

      def statistics(options = {})
        (options.delete(:api) || Mailjet::Api.singleton).reportEmailstatistics(options)["stats"]
      end

      def geolocation(options = {})
        (options.delete(:api) || Mailjet::Api.singleton).reportGeoip(options)["geos"]
      end

      def agents(options = {})
        (options.delete(:api) || Mailjet::Api.singleton).reportUseragents(options)["user_agents"] || []
      end
    end
  end
end
