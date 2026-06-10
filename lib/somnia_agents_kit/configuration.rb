# frozen_string_literal: true

module SomniaAgentsKit
  class Configuration
    attr_accessor :contracts_path,
                  :network,
                  :callback_address,
                  :callback_selector

    def initialize
      @contracts_path = 'contracts'
      @network = 'somniaShannon'
      @callback_selector = '0x00000000'
    end
  end

  module_function

  def configuration
    @configuration ||= Configuration.new
  end

  def configure
    yield(configuration)
  end
end
