require 'ice_cube'

class ScheduleSerializer
  def dump(obj)
    return if obj.nil?

    unless obj.is_a?(IceCube::Schedule)
      raise ActiveRecord::SerializationTypeMismatch,
            "Attribute was supposed to be a IceCube::Schedule, but was a #{obj.class}. -- #{obj.inspect}"
    end

    obj.to_yaml
  end

  def load(yaml)
    return IceCube::Schedule.new if yaml.nil?
    return yaml unless yaml.is_a?(String) && yaml =~ /^---/

    IceCube::Schedule.from_yaml(yaml)
  end
end
