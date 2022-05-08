class ApplicationService
  class << self
    def call(...)
      new(...).call
    end
  end

  def call
    raise NotImplementedError
  end
end
