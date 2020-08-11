class Form::Schedule < ApplicationRecord
    REGISTRABLE_ATTRIBUTES = %i(exercise training_date)
    attr_accessor :exercise
    attr_accessor :training_date
end
