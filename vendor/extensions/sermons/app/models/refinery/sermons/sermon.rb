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
      has_and_belongs_to_many :categories, class_name: '::Refinery::Sermons::SermonCategory', join_table: 'refinery_sermons_sermon_categories', foreign_key: 'sermon_id', association_foreign_key: 'category_id'

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

        def by_date
          by_date = {}

          recent.each do |sermon|
            year = sermon.date.year
            month = Date::MONTHNAMES[sermon.date.month]
            by_date[year] ||= {}
            by_date[year][month] ||= []
            by_date[year][month] << sermon
          end

          by_date
        end
      end
    end
  end
end
