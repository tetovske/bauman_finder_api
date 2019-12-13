# frozen_string_literal: true

# Helpers for models
module ModelHelpers
  # Student validation
  class StudentValidator < Service
    include Dry::AutoInject(Container)[
      'models.student'
    ]

    def call(student)
      yield uniq_id?(student.identifier)
      yield uniq_name?(student)
    end

    def uniq_id?(id)
      return Success() if student.find_by(identifier: id).nil?

      Failure(:id_is_not_uniq)
    end

    def uniq_name?(name, second_name, mid_name)
      res = student.where('name = ? AND last_name = ? AND mid_name = ?',
                          name, second_name, mid_name)
      if res.empty?
        Success()
      else
        Failure(:name_is_not_uniq)
      end
    end
  end
end
