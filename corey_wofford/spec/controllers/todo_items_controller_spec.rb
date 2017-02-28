require 'rails_helper'

# So specs will run and not throw scary errors before RepliesController is implemented
begin
  TodoItemsController
rescue
  TodoItemsController = nil
end

RSpec.describe TodoItemsController, :type => :controller do

  create_jill_with_todo_list
  let(:jack_bruce) { User.create!(username: "jack_bruce", password: "abcdef") }
  let(:jack_todo) { TodoList.create!(name: "chores", description: "gotta love em", user: jack_bruce)}

  before(:each) do
    allow_message_expectations_on_nil
  end

  describe "POST #create" do
    before do
      allow(controller).to receive(:current_user) { jack_bruce }
    end

    context "when logged in as the todo list's owner" do
      context "with invalid params" do
        it "does not create the todo item and redirects to the todo list show page" do
          post :create, todo_item: {todo_list_id: jack_todo.id}
          expect(response).to redirect_to(todo_list_url(jack_todo))
          expect(TodoItem.exists?(body: "vacuum")).to be false
        end
      end

      context "with valid params" do
        it "creates the todo item and redirects to the todo list show page" do
          post :create, todo_item: {todo_list_id: jack_todo.id, body: "vacuum"}
          expect(response).to redirect_to(todo_list_url(jack_todo))
          expect(TodoItem.exists?(body: "vacuum")).to be true
        end
      end
    end

    context "when logged in as a different user" do
      it "does not allow creation of the todo item" do
        begin
          post :create, todo_item: {todo_list_id: jill_todo_list.id, body: "eat potatoes"}
        rescue ActiveRecord::RecordNotFound
        end

        expect(TodoItem.exists?).to be false
      end
    end

  end

  describe "DELETE #destroy" do
    let(:first_todo_item) { TodoItem.create!({todo_list_id: jill_todo_list.id, body: "eat potatoes"}) }

    context "when logged in as the todo list's owner" do
      before do
        allow(controller).to receive(:current_user) { jill }
      end

      it "removes the todo item and redirects back to the todo show" do
        delete :destroy, id: first_todo_item.id
        expect(response).to redirect_to(todo_list_url(jill_todo_list))
        expect(TodoItem.exists?(first_todo_item.id)).to be false
      end
    end

    context "when logged in as a different user" do
      before do
        allow(controller).to receive(:current_user) { jack_bruce }
      end

      it "does not delete the todo item" do
        begin
          delete :destroy, id: first_todo_item.id
        rescue ActiveRecord::RecordNotFound
        end

        expect(TodoItem.exists?(first_todo_item.id)).to be true
      end
    end

  end
end
