require 'rails_helper'

describe "User comments on issue" do
  let!(:issue) { create(:issue) }
  let!(:user) { logged_in_user }

  context "comment attributes are invalid" do
    scenario "comment is not saved to the database and user sees helpful message" do
      visit issue_path(issue)
      expect(page).to have_content issue.title
      expect(Comment.count).to eq 0

      fill_in 'comment_body', with: ""
      click_on 'Submit Comment'

      expect(Comment.count).to eq 0

      expect(page).to have_content "Comment body can't be blank"
    end
  end

  context "comment attributes are valid" do
    scenario "comment is saved to database and appears on the issue show page" do
      visit issue_path(issue)
      expect(page).to have_content issue.title
      expect(Comment.count).to eq 0

      fill_in 'comment_body', with: "This is such a lovely comment."
      click_on 'Submit Comment'

      expect(Comment.count).to eq 1

      comment = issue.comments.first
      expect(page).to have_current_path(issue_path(issue))
      expect(page).to have_content(issue.title)
      expect(page).to have_content(comment.body)
      expect(page).to have_content(comment.user_name)
      expect(page).to have_content(comment.display_date)
    end
  end
end

describe "Guest cannot comment on issues" do
  let!(:issue) { create(:issue) }

  scenario "comment form does not appear for guests" do
    visit issue_path(issue)

    expect(page).to have_content issue.title
    expect(page).to have_content issue.description
    expect(page).not_to have_css(:comment_form)
  end
end
