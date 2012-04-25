RSpec.configure do |config|
  config.before :each do
    t = Time.local 2012, 1, 1
    Timecop.travel(t)
  end

  config.after :each do
    Timecop.return
  end
end
