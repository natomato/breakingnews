class Matcher
  include ActiveModel::Validations

  def initialize()

  end

  def persisted?
    false
  end

end