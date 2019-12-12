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

    end


    def uniq_id?(id)
      return Success(true) if student.find_by(:identifier => id).nil?
      return Failure(false)
    end

    def uniq_name?(name, second_name, mid_name)
      res = student.where("name = ? AND last_name = ? AND mid_name = ?", 
                      name, second_name, mid_name)
      puts "res: #{res.first}"
      return Success(true) if res.nil?
      return Failure(false)
    end
  end
end