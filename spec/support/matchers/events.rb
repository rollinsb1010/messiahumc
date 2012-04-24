RSpec::Matchers.define :be_repeating do |expected|
  match do |actual|
    actual.repeats?.should be_true
  end

  failure_message_for_should do |actual|
    "expected #{actual} to repeat"
  end

  failure_message_for_should_not do |actual|
    "expected #{actual} not to repeat"
  end

  description do
    "be repeating"
  end
end
