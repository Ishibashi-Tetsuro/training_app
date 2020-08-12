class Form::Schedule < Schedule
    REGISTRABLE_ATTRIBUTES = %i(exercise_id training_date user_id)
    attr_accessor :exercise_id
    attr_accessor :training_date
    attr_accessor :user_id
end
