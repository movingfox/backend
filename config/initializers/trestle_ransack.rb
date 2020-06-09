# frozen_string_literal: true

# These next few classes and overrides all allow a search form to be set inside of admin builders
# so that we can get a search sidebar next to tables
module RansackableAdminBuilder
  def search_form(collection = nil, &block)
    ransackable(collection)
    admin.search_form = Trestle::Form.new(&block)
  end

  def ransackable(base_collection = nil)
    q = nil

    before_action do
      @q = q
    end

    collection do |params|
      q = if base_collection.nil?
            model.ransack(params[:q])
          else
            base_collection.call.ransack(params[:q])
          end
      q.result
    end
  end
end
Trestle::Resource::Builder.prepend RansackableAdminBuilder

module Trestle
  class Resource
    class << self
      attr_accessor :search_form
    end
  end
end

class NoErrorsFormBuilder < Trestle::Form::Builder
  def errors(_name)
    []
  end
end
