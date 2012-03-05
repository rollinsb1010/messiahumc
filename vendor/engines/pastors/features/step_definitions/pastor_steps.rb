Given /^I have no pastors$/ do
  Pastor.delete_all
end

Given /^I (only )?have pastors titled "?([^\"]*)"?$/ do |only, titles|
  Pastor.delete_all if only
  titles.split(', ').each do |title|
    Pastor.create(:name => title)
  end
end

Then /^I should have ([0-9]+) pastors?$/ do |count|
  Pastor.count.should == count.to_i
end
