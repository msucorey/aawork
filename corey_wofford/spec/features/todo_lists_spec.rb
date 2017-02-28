require 'rails_helper'

feature "Creating a todo list (hint: make sure your capitalization is exact!)", type: :feature do
  context "when logged in" do
    before :each do
      register_as_jack_bruce
      visit new_todo_list_url
    end

    it "takes a name and a description" do
      expect(page).to have_content 'Name'
      expect(page).to have_content 'Description'
    end

    context "on failed save" do
      before :each do
        make_todo_list("", "Rad things todo")
      end

      it "has a pre-filled form (with the data previously input)" do
        expect(find_field('Description').value).to eq('Rad things todo')
      end

      it "still allows for a successful save" do
        fill_in 'Name', with: 'My First Todo List'
        click_button 'Create New Todo List'
        expect(page).to have_content 'My First Todo List'
      end
    end
  end
end

feature "Seeing all todo_lists" do
  context "when logged in" do
    before :each do
      register_as_jack_bruce
      make_todo_list('My First Todo List')
      make_todo_list('My Second Todo List')
      visit todo_lists_path
    end

    it "shows all the todo_lists for the current user" do
      expect(page).to have_content 'My First Todo List'
      expect(page).to have_content 'My Second Todo List'
    end

    it "links to each of the todo_lists with the todo list names" do
      click_link 'My First Todo List'
      expect(page).to have_content 'My First Todo List'
      expect(page).to_not have_content('My Second Todo List')
    end
  end

  context "when signed in as another user" do
    before :each do
      register('jack_bruce')
      click_button 'Sign Out'
      register('goodbye_world')
      make_todo_list('Goodbye cruel world')
      click_button 'Sign Out'
      sign_in('jack_bruce')
    end

    it "does not show others todo_lists" do
      visit todo_lists_path
      expect(page).not_to have_content('Goodbye cruel world')
    end
  end
end

feature "Showing a todo list" do
  context "when logged in" do
    before :each do
      register('jack_bruce')
      make_todo_list('Hello, World!', 'Rad things to do.')
      visit todo_lists_path
      click_link 'Hello, World!'
    end

    it "displays the todo list name" do
      expect(page).to have_content 'Hello, World!'
    end

    it "displays the todo list description" do
      expect(page).to have_content 'Rad things to do.'
    end
  end
end

feature "Editing a todo list" do
  before :each do
    register_as_jack_bruce
    make_todo_list('This is a name', 'This is a description')
    visit todo_lists_path
    click_link 'This is a name'
  end

  it "has a link on the show page to edit a todo list" do
    expect(page).to have_content 'Edit Todo List'
  end

  it "shows a form to edit the todo list" do
    click_link 'Edit Todo List'
    expect(page).to have_content 'Name'
    expect(page).to have_content 'Description'
  end

  it "has all the data pre-filled" do
    click_link 'Edit Todo List'
    expect(find_field('Name').value).to eq('This is a name')
    expect(find_field('Description').value).to eq('This is a description')
  end

  context "on successful update" do
    let!(:show_page) { current_path }

    before :each do
      click_link 'Edit Todo List'
    end

    it "redirects to the todo list show page" do
      fill_in 'Name', with: 'A new name'
      click_button 'Update Todo List'
      expect(page).to have_content 'A new name'

      expect(current_path).to eq(show_page)
    end
  end

  context "on a failed update" do
    let!(:show_page) { current_path }

    before :each do
      click_link 'Edit Todo List'
    end

    it "returns to the edit page" do
      fill_in 'Name', with: ''
      click_button 'Update Todo List'

      # failed; should be able to try again
      fill_in 'Name', with: 'Ginger Baker'
      click_button 'Update Todo List'

      expect(current_path).to eq(show_page)
      expect(page).to have_content("Ginger Baker")
    end

    it "preserves the attempted updated data" do
      fill_in 'Name', with: ''
      click_button 'Update Todo List'

      expect(find_field('Name').value).to eq("")
    end
  end
end
