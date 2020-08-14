class Form::Schedule < Schedule
    REGISTRABLE_ATTRIBUTES = %i(part training_date user_id)
    attr_accessor :part
    attr_accessor :training_date
    attr_accessor :user_id
end
