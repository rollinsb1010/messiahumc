module Refinery
  module Sermons
    class Sermon < ::SearchableModel
      extend FriendlyId
      friendly_id :title, use: :slugged

      self.table_name = 'refinery_sermons'

      acts_as_indexed fields: [:title, :location, :description, :scripture_reading]

      validates :pastor, presence: true
      validates :title, presence: true
      validates :date, presence: true
      validates :location, presence: true, inclusion: {in: %w(sanctuary celebration)}

      belongs_to :image, class_name: '::Refinery::Image'
      belongs_to :mp3_file, class_name: '::Refinery::Resource'
      belongs_to :pastor, class_name: '::Refinery::Pastors::Pastor'

      def url
        ::Refinery::Core::Engine.routes.url_helpers.sermons_sermon_path(self.slug)
      end

      def summary
        description
      end

      class << self
        def recent
          includes(:pastor).order('date DESC')
        end
      end
    end
  end
end
