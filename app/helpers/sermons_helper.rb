module SermonsHelper
  def title
    title = @sermon_category ? @sermon_category.name : ''
    "#{title} Sermons"
  end
end
