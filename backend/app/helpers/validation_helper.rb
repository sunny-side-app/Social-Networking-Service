module ValidationHelper
  def self.present?(value)
    !value.nil? && (value.respond_to?(:strip) ? !value.strip.empty? : true)
  end

  def self.validate_params(params, rules = {})
    errors = {}
    rules.each do |field, rule|
      value = params[field.to_s]
      if rule[:presence] && !present?(value)
        errors[field] = 'must be provided'
      end
      if rule[:min_length] && value.to_s.length < rule[:min_length]
        errors[field] = "must be at least #{rule[:min_length]} characters"
      end
    end
    errors
  end
end
