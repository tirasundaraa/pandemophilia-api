# frozen_string_literal: true

# UserQuery service
class UserQuery

  class << self
    def call(query_params, options = {})
      new(query_params, options).call
    end
  end

  attr_reader :query_params, :options

  def initialize(query_params, options = {})
    @default_scope  = User.all
    @default_scope  = @default_scope.includes(options[:includes]) if options[:includes]
    @query_params   = query_params
    @options        = options
  end

  def call
    scoped = filter_by_excluded_ids(default_scope, options[:exclude_ids]) if options[:exclude_ids]
    scoped = filter_by_pandemophilia(scoped, query_params)
    scoped.order(id: :desc)
  end

  private

  attr_reader :default_scope

  def filter_by_pandemophilia(scope, params)
    return scope unless params[:is_pandemophilia].present?

    is_pandemophilia = ActiveModel::Type::Boolean.new.cast(params[:is_pandemophilia])

    return scope.not_pandemophilia unless is_pandemophilia

    scope.pandemophilia
  end

  def filter_by_excluded_ids(scope, user_ids)
    scope.where.not(id: Array(user_ids))
  end
end
