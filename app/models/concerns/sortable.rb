module Sortable
  extend ActiveSupport::Concern

  included do
    scope :sort_result, ->(params, default=nil, default_order=nil) do
      params = params.deep_symbolize_keys
      sort_field = params[:sort] || default || :id
      orientation = params[:orientation] || default_order || :desc
      data = {}
      data[sort_field.to_sym] = orientation.to_sym
      return self.order(data) if self.has_attribute?(sort_field.to_sym)
      return self.send("sort_#{sort_field}", orientation) if self.respond_to?("sort_#{sort_field}")
      all
    end
  end
end
