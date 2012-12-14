module Refinery
  module Signups
    class ParticipantsController < ::ApplicationController

      def create
        @participant = Participant.new(params)
      end


    protected

    end
  end
end
