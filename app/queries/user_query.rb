# frozen_string_literal: true

# UserQuery service
class UserQuery

  class << self
    def call(query_params)
      new(query_params).call
    end
  end

  attr_reader :query_params

  def initialize(query_params)
    @default_scope  = User.all
    @query_params   = query_params
  end

  def call
    scoped = filter_by_pandemophilia(default_scope, query_params)
    scoped.order(created_at: :desc)
  end

  private

  attr_reader :default_scope

  def filter_by_pandemophilia(scope, params)
    return scope unless params[:is_pandemophilia].present?

    is_pandemophilia = ActiveModel::Type::Boolean.new.cast(params[:is_pandemophilia])

    return scope.not_pandemophilia unless is_pandemophilia

    scope.pandemophilia
  end
end
