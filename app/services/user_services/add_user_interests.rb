# frozen_string_literal: true

module UserServices
  # AddUserInterests service
  class AddUserInterests
    include Common
    include Dry::Monads[:do]

    class << self
      def call(user_id, params = {})
        new(user_id, params).call
      end
    end

    def initialize(user_id, params = {})
      @user_id      = user_id
      @interest_ids = params.fetch(:interest_ids)
      @question     = params.fetch(:question)
      @answer       = params.fetch(:answer)
    end

    def call
      user = yield find_user(user_id)
      interests = yield fetch_intersts(interest_ids)
      user = yield update_user_interests(user, interests)
      q_n_a = yield update_user_question_answer(user, q: question, a: answer)

      Success(OpenStruct.new({ user: user, interests: interests, question_answer: q_n_a }))
    end

    private

    attr_reader :user_id, :interest_ids, :question, :answer

    def update_user_question_answer(user, q:, a:)
      if q_n_a = user.question_answer
        q_n_a.question  = q
        q_n_a.answer    = a
      else
        q_n_a = user.build_question_answer(question: q, answer: a)
      end

      if q_n_a.save
        Success(q_n_a)
      else
        Failure(OpenStruct.new({ code: 422, message: q_n_a.errors.messages }))
      end
    end

    def update_user_interests(user, interests)
      user.interests = interests

      Success(user)
    end

    def fetch_intersts(interest_ids)
      interests = Interest.where(id: Array(interest_ids))

      Success(interests)
    end
  end
end
