module RSpec::Rails::Matchers
  module RoutingMatchers
    extend RSpec::Matchers::DSL
    def locale_route_to(*expected)
      expected[0][:locale] = :en
      RouteToMatcher.new(self, *expected)
    end
  end
end
