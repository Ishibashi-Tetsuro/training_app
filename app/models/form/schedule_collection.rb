class Form::ScheduleCollection < Form::Base
  DEFAULT_ITEM_COUNT = 7
  attr_accessor :schedules

  def initialize(attributes = {})
    super attributes
    self.schedules = DEFAULT_ITEM_COUNT.times.map { Schedule.new } unless schedules.present?
  end

  def schedules_attributes=(attributes)
    self.schedules = attributes.map { |_, v| Schedule.new(v) }
  end


  def save
    Schedule.transaction do
      self.schedules.map(&:save!)
    end
      return true
    rescue => e
      return false
  end

  # 以下は"https://rails.densan-labs.net/form/bulk_registration_form.html"の原型

  # def schedules_attributes=(attributes)
  #   self.schedules = attributes.map do |_, schedule_attributes|
  #     Form::Schedule.new(schedule_attributes).tap { |v| v.availability = false }
  #   end
  # end

  # def valid?
  #   valid_schedules = target_schedules.map(&:valid?).all?
  #   super && valid_schedules
  # end

  # def save
  #   return false unless valid?
  #   Schedule.transaction { target_schedules.each(&:save!) }
  #   true
  # end

  # def target_schedules
  #   self.schedules.select { |v| value_to_boolean(v.register) }
  # end

end
