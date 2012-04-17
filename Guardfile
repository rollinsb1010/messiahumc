extensions = Dir[File.expand_path('../vendor/extensions/*', __FILE__)]

guard 'spork', wait: 60, cucumber: false, rspec_env: { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch(%r{config/environments/.+\.rb$})
  watch(%r{config/initializers/.+\.rb$})
  watch('spec/spec_helper.rb')
  watch(%r{spec/support/.+\.rb$})

  extensions.each do |extension|
    watch(%r{^#{extension}/spec/support/.+\.rb$})
  end
end

spec_paths = extensions.map{|e| "#{e}/spec"}
spec_paths << 'spec'
guard 'rspec', version: 2, spec_paths: spec_paths,
  cli: (File.read('.rspec').split("\n").join(' ') if File.exists?('.rspec')) do
  watch(%r{spec/.+_spec\.rb$})
  watch(%r{app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/requests/#{m[1]}_spec.rb"] }
  watch(%r{spec/support/(.+)\.rb$})                  { "spec" }
  watch("spec/spec_helper.rb")                        { "spec" }
  watch("config/routes.rb")                           { "spec/routing" }
  watch("app/controllers/application_controller.rb")  { "spec/controllers" }
  # Capybara request specs
  watch(%r{app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }

  extensions.each do |extension|
    watch(%r{#{extension}/spec/.+_spec\.rb$})
    watch(%r{#{extension}/app/(.+)\.rb$})                           { |m| "#{extension}/spec/#{m[1]}_spec.rb" }
    watch(%r{#{extension}/lib/(.+)\.rb$})                           { |m| "#{extension}/spec/lib/#{m[1]}_spec.rb" }
    watch(%r{#{extension}/app/controllers/(.+)_(controller)\.rb$})  { |m| ["#{extension}/spec/routing/#{m[1]}_routing_spec.rb", "#{extension}/spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "#{extension}/spec/requests/#{m[1]}_spec.rb"] }
    watch(%r{#{extension}/spec/support/(.+)\.rb$})                  { "#{extension}/spec" }
    watch("#{extension}/spec/spec_helper.rb")                        { "#{extension}/spec" }
    watch("#{extension}/config/routes.rb")                           { "#{extension}/spec/routing" }
    watch("#{extension}/app/controllers/application_controller.rb")  { "#{extension}/spec/controllers" }
    # Capybara request specs
    watch(%r{#{extension}/app/views/(.+)/.*\.(erb|haml)$})          { |m| "#{extension}/spec/requests/#{m[1]}_spec.rb" }
  end
end
