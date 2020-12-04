# frozen_string_literal: true

# UserQuery service
class InterestQuery

  class << self
    def call(query_params)
      new(query_params).call
    end
  end

  attr_reader :query_params

  def initialize(query_params)
    @default_scope  = Interest.all
    @query_params   = query_params
  end

  def call
    default_scope.order(:name)
  end

  private

  attr_reader :default_scope
end
