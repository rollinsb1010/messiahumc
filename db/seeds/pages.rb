if Refinery::Page.where(:menu_match => "^/$").empty?
  home_page = Refinery::Page.create!({:title => "Home",
              :deletable => false,
              :link_url => "/",
              :menu_match => "^/$"})
  home_page.parts.create({
                :title => "Body",
                :body => "<p>Welcome to our site. This is just a place holder page while we gather our content.</p>",
                :position => 0
              })
  home_page.parts.create({
                :title => "Side Body",
                :body => "<p>This is another block of content over here.</p>",
                :position => 1
              })

  home_page_position = -1
  page_not_found_page = home_page.children.create(:title => "Page not found",
              :menu_match => "^/404$",
              :show_in_menu => false,
              :deletable => false)
  page_not_found_page.parts.create({
                :title => "Body",
                :body => "<h2>Sorry, there was a problem...</h2><p>The page you requested was not found.</p><p><a href='/'>Return to the home page</a></p>",
                :position => 0
              })
end
