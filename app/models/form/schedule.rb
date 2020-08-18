class Form::Schedule < Schedule
    REGISTRABLE_ATTRIBUTES = %i(part training_date user_id work shape)
    attr_accessor :part
    attr_accessor :training_date
    attr_accessor :user_id
    attr_accessor :work
    attr_accessor :shape
end
