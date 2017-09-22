module ProPublica
  module Connection
    def connect
      ENV.fetch("PROPUBLICA_API")
    end
  end
end
