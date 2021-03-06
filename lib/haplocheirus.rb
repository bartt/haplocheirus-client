require 'thrift'
require 'thrift_client'

require 'haplocheirus/thrift/timeline_store'
require 'haplocheirus/service'
require 'haplocheirus/client'

module Haplocheirus
  autoload :MockService, 'haplocheirus/mock_service'

  # Convenience method for:
  #
  #    s = Haplocheirus::Service.new(*args)
  #    Haplocheirus::Client.new(s)
  #
  def self.new(*args)
    service = Haplocheirus::Service.new(*args)
    Haplocheirus::Client.new(service)
  rescue Haplocheirus::Service::ServiceDisabled
    nil
  end

  # Nice-to-haves...
  class TimelineSegment #:nodoc:

    def hit?
      state == TimelineSegmentState::HIT
    end

    def miss?
      state == TimelineSegmentState::MISS
    end

    def timeout?
      state == TimelineSegmentState::TIMEOUT
    end

  end

end
