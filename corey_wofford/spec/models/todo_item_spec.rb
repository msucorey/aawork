require 'rails_helper'

begin
  TodoItem
rescue
  TodoItem = nil
end

RSpec.describe TodoItem, :type => :model do
  it { should belong_to(:todo_list) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:todo_list) }
end
