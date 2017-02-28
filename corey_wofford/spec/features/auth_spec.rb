require 'rails_helper'

feature "Sign up (hint: make sure your capitalization is exact!)", type: :feature   do
  before :each do
    visit new_user_path
  end

  it "takes a username and password" do
    expect(page).to have_content "Username"
    expect(page).to have_content "Password"
  end

  it "logs the user in and redirects them to todo lists index on success" do
    register_as_jack_bruce
    # add user name to application.html.erb layout
    expect(page).to have_content 'jack_bruce'
    expect(current_path).to eq(todo_lists_path)
  end
end

feature "Sign out" do
  it "has a sign out button" do
    register_as_jack_bruce
    expect(page).to have_button 'Sign Out'
  end

  it "logs a user out on click" do
    register_as_jack_bruce

    click_button 'Sign Out'

    # redirect to login page
    expect(current_path).to eq(new_session_path)
  end
end

feature "Sign in" do
  it "has a sign in page" do
    visit new_session_path
    expect(page).to have_content "Log In"
  end

  it "takes a username and password" do
    visit new_session_path
    expect(page).to have_content "Username"
    expect(page).to have_content "Password"
  end

  it "logs in a user and takes them to todo lists index on success" do
    User.create!(username: 'jack_bruce', password: 'abcdef')

    # Sign in as newly created user
    sign_in_as_jack_bruce
    expect(page).to have_content "jack_bruce"
    expect(current_path).to eq(todo_lists_path)
  end
end
