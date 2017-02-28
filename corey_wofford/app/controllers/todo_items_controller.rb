class TodoItemsController < ApplicationController

  def new
  end

  def create
    @item = TodoItem.new(item_params)
    if @item && (@item.todo_list.user.id == current_user.id) && @item.save
      redirect_to todo_list_url(@item.todo_list)
    else
      flash[:errors] = @item.errors.full_messages
      redirect_to todo_list_url(@item.todo_list)
    end
  end

  def destroy
    @item = TodoItem.find(params[:id])
    if @item && (@item.todo_list.user.id == current_user.id)
      @item.destroy
      redirect_to todo_list_url(@item.todo_list)
    else
      redirect_to todo_lists_url
    end
  end

  def item_params
    params.require(:todo_item).permit(:body, :todo_list_id)
  end
end
