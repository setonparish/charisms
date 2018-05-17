class EmailValidator < ActiveModel::EachValidator
  EMAIL_REGEX = /.+@.+\..+/i

  def validate_each(object, attribute, value)
    unless value =~ EMAIL_REGEX
      object.errors[attribute] << (options[:message] || "is not a valid format")
    end
  end
end

