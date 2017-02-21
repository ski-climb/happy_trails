require './db/seeds/issues_seed'

class Seed
  def self.start
    seed = Seed.new
    seed.remove_all_existing_data
    seed.generate_admin
    seed.generate_users
    seed.generate_issues
    seed.generate_comments
  end

   def remove_all_existing_data
    puts "Clearing out the data currently in your database (Ctrl-C now if that's a bad thing...)"
    sleep(5)
    puts "Too late!"
    Photo.destroy_all
    Comment.destroy_all
    Issue.destroy_all
    Admin.destroy_all
    User.destroy_all
    puts "Creating fresh, new data"
  end

  def generate_admin
    Admin.create!(
      first_name: 'Trail',
      last_name:  'God',
      email:      'admin@example.com',
      password:   'password'
    )
  end

  def generate_users
    4.times { FactoryGirl.create(:user) }
  end

  def generate_issues
    IssuesSeed.start
  end

  def generate_comments
    20.times do
      FactoryGirl.create(:comment, user: User.all.sample, issue: Issue.all.sample)
    end
  end
end

Seed.start

