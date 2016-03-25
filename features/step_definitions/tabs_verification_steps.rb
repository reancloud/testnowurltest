When /^I follow tabs on page$/ do
  @page_tab = TabVerificationPage .new(@driver)
  @page_tab.first_tab.click
  @page_tab.second_tab.click

end

Then /^I verify tabs is on page$/ do
  @page_tab = TabVerificationPage .new(@driver)
  @page_tab.first_tab.text.include?('Amazing Services').should == true
  @page_tab.second_tab.text.include?('Testimonials').should == true

end

And /^I follow link on page$/ do
  @page_tab = TabVerificationPage .new(@driver)
  @page_tab.third_tab.click
end

Then /^I verify link open in page$/ do
  @driver.find_element(xpath: "//h1").text.include?('Get Chef certified to become a DevOps expert').should == true
end