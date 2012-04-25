extensions = Dir[File.expand_path('../vendor/extensions/*', __FILE__)].map { |e| e.split('/').last }

guard 'spork', wait: 60, cucumber: false, rspec_env: { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{config/environments/.+\.rb$})
  watch(%r{config/initializers/.+\.rb$})
  watch('spec/spec_helper.rb')
  watch(%r{spec/support/.+\.rb$})

  extensions.each do |extension|
    watch(%r{^vendor/extensions/#{extension}/spec/support/.+\.rb$})
  end
end

#spec_paths = extensions.map{ |extension| "vendor/extensions/#{extension}/spec" }
#spec_paths << 'spec'

guard 'rspec', version: 2, all_on_start: false, all_after_pass: false do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/requests/#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { spec_paths }
  watch("spec/spec_helper.rb")                        { spec_paths }
  watch("config/routes.rb")                           { "spec/routing" }
  watch("app/controllers/application_controller.rb")  { "spec/controllers" }
  # Capybara request specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }

  #extensions.each do |extension|
    #watch(%r{^vendor/extensions/#{extension}/spec/.+_spec\.rb$})
    #watch(%r{^vendor/extensions/#{extension}/app/(.+)\.rb$})                           { |m| "vendor/extensions/#{extension}/spec/#{m[1]}_spec.rb" }
    #watch(%r{^vendor/extensions/#{extension}/lib/(.+)\.rb$})                           { |m| "vendor/extensions/#{extension}/spec/lib/#{m[1]}_spec.rb" }
    #watch(%r{^vendor/extensions/#{extension}/app/controllers/(.+)_(controller)\.rb$})  { |m| ["vendor/extensions/#{extension}/spec/routing/#{m[1]}_spec.rb", "vendor/extensions/#{extension}/spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "vendor/extensions/#{extension}/spec/requests/#{m[1]}_spec.rb"] }
    #watch(%r{^vendor/extensions/#{extension}/spec/support/(.+)\.rb$})                  { "vendor/extensions/#{extension}/spec" }
    #watch("vendor/extensions/#{extension}/spec/spec_helper.rb")                        { "vendor/extensions/#{extension}/spec" }
    #watch("vendor/extensions/#{extension}/config/routes.rb")                           { "vendor/extensions/#{extension}/spec/routing" }
    #watch("vendor/extensions/#{extension}/app/controllers/application_controller.rb")  { "vendor/extensions/#{extension}/spec/controllers" }
    ## Capybara request specs
    #watch(%r{^vendor/extensions/#{extension}/app/views/(.+)/.*\.(erb|haml)$})          { |m| "vendor/extensions/#{extension}/spec/requests/#{m[1]}_spec.rb" }
  #end
end
