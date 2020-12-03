# frozen_string_literal: true

module AuthServices
  # Authorization service
  class AuthorizeApiRequest
    AUTHORIZATION_HEADERS_KEY = 'Authorization'.freeze

    include Dry::Monads[:result, :do]

    class << self
      def call(headers)
        new(headers).call
      end
    end

    def initialize(headers = {})
      @headers = headers
    end

    def call
      token = yield acquire_auth_token(headers)
      decoded_token = yield decode_auth_token(token)
      user = find_user(decoded_token[:user_id])

      Success(OpenStruct.new({ user: user }))
    end

    private

    attr_reader :headers

    def find_user(id)
      user = User.find_by(id: id)

      if user
        Success(user)
      else
        Failure(OpenStruct.new({ code: 404, message: :user_not_found }))
      end
    end

    def decode_auth_token(token)
      decoded = JsonWebToken.decode(token)

      if decoded
        Success(decoded)
      else
        Failure(OpenStruct.new({ code: 401, message: :invalid_token }))
      end
    end

    def acquire_auth_token(req_headers)
      if req_headers[AUTHORIZATION_HEADERS_KEY].present?

        token = req_headers[AUTHORIZATION_HEADERS_KEY].split(' ').last

        Success(token)
      else
        Failure(OpenStruct.new({ code: 401, message: :missing_token }))
      end
    end
  end
end
