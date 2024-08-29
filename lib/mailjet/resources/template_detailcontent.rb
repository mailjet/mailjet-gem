module Mailjet
  class Template_detailcontent
    include Mailjet::Resource
    self.action = 'detailcontent'
    self.resource_path = "REST/template/id/#{self.action}"
    self.public_operations = [:get,:post]
    self.filters = [:api_key, :categories, :categories_selection_method, :edit_mode, :name, :owner_type, :purposes, :purposes_selection_method, :user]
    self.resourceprop = [:author, :categories, :copyright, :description, :edit_mode, :is_starred, :name, :owner_type, :presets, :purposes]

    def self.find(id, options = {})
      self.resource_path = create_action_resource_path(id)

      opts = define_options(options)
      response = connection(opts).get(default_headers)
      attributes = parse_api_json(response.body).first

      instanciate_from_api(attributes)
    rescue Mailjet::CommunicationError => e
      if e.code == 404
        nil
      else
        raise e
      end
    end
  end
end
