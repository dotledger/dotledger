class PoltergeistLogger
  def self.write(str)
    Rails.logger.info "Poltergeist: #{str}"
  end
end
