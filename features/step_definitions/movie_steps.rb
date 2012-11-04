# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.map do |movie|
    m = Movie.new movie
    m.save!
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rs = rating_list.split ','
  checks = rs.map do |r|
    if uncheck==nil
      %Q{I check "ratings_#{r.strip}" \n}
    else 
      %Q{I uncheck "ratings_#{r.strip}" \n}
    end
  end
  
  checks = "When " + checks.join("And ")
  steps checks  
end

Then /^I should see all of the movies$/ do
  assert page.has_xpath?("//table[@id='movies']")
  assert  page.has_xpath?("//table[@id='movies']/tbody/tr", :count=>10)  
end

Then /^"(.*?)" appears before "(.*?)"$/ do |arg1, arg2|
  regexp = /#{arg1}.*#{arg2}/m #  /m means match across newlines
  assert  page.body =~ regexp
end
