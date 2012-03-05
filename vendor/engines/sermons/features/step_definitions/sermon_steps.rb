Given /^I have no sermons$/ do
  Sermon.delete_all
end

Given /^I (only )?have sermons titled "?([^\"]*)"?$/ do |only, titles|
  Sermon.delete_all if only
  titles.split(', ').each do |title|
    Sermon.create(:speaker => title)
  end
end

Then /^I should have ([0-9]+) sermons?$/ do |count|
  Sermon.count.should == count.to_i
end
