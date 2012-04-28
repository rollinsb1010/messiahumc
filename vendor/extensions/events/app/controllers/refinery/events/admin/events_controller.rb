module Refinery
  module Events
    module Admin
      class EventsController < ::Refinery::AdminController
        before_filter :get_ministries
        before_filter :parse_date, :clean_nullable_time_fields, only: [:update, :create]
        helper :events

        crudify :'refinery/events/event', xhr_paging: true

        def get_ministries
          @ministries = ::Refinery::Ministries::Ministry.all
        end

        def parse_date
          params[:event][:date] = Chronic.parse(params[:date])
        end

        def clean_nullable_time_fields
          event = params[:event]

          nullable_fields = %w(start_time end_time)

          nullable_fields.each do |field|
            if event["#{field}(4i)"].empty? or event["#{field}(5i)"].empty?
              (1..3).each { |index| event["#{field}(#{index}i)"] = ''}
            end
          end

        end
      end
    end
  end
end
