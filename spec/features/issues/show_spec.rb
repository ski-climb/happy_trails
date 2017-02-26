require 'rails_helper'

describe "viewing an individual issue" do
  let!(:issue) { create(:issue) }
  let!(:photo) { create(:photo, issue: issue) }
  before { logged_in_user }

  context "issue has not been resolved nor been commented on" do
    scenario "original issue data is displayed" do
      visit issue_path(issue)

      expect(page).to have_content issue.submitter_name
      expect(page).to have_content issue.title
      expect(page).to have_content issue.description
      expect(page).to have_content issue.category.capitalize
      expect(page).to have_content issue.severity.capitalize
      expect(page).to have_content issue.latitude.to_s[0..9]
      expect(page).to have_content issue.longitude.to_s[0..9]
      expect(page).to have_content issue.resolved_status

      # A very ugly way of checking if the image appears on the page
      expect(page).to have_xpath("//img[@src=\"#{issue.photos.first.url.url}\"]")
    end
  end
end
