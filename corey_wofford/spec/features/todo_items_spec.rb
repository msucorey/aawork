require 'rails_helper'

feature "Adding Todo Items (hint: make sure your capitalization is exact!)", type: :feature do
  before :each do
    register_as_jack_bruce
  end

  it "has an add todo item form on the todo list show page" do
    make_todo_list
    expect(page).to have_content 'Add Todo Item'
  end

  it "shows the todo list show page on submit" do
    make_todo_list("chores")
    fill_in 'Todo', with: 'Clean Room'
    click_button 'Add Todo Item'
    expect(page).to have_content 'chores'
  end

  it "adds the todo item to the todo list on clicking the submit button" do
    make_todo_list
    fill_in 'Todo', with: 'Clean Room'
    click_button 'Add Todo Item'
    expect(page).to have_content 'Clean Room'
  end
end

feature "Deleting todo_items" do
  before :each do
    register_as_jack_bruce
    make_todo_list
    add_todo_item
  end

  it "displays a remove button next to each todo_item" do
    expect(page).to have_button 'Remove Todo Item'
  end

  it "shows the todo list show page on click" do
    click_button 'Remove Todo Item'
    expect(current_path).to eq(todo_list_path(TodoList.last))
  end

  it "removes the todo item on click" do
    click_button 'Remove Todo Item'
    expect(page).to_not have_content 'be awesome'
  end
end
