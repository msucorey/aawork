class TodoListsController < ApplicationController

  before_filter :ensure_logged_in

  def index
    @todolists = TodoList.all
  end

  def show
    @todolist = TodoList.find(params[:id])
    if @todolist.user_id == current_user.id
      render :show
    else
      redirect_to todo_lists_url
    end
  end

  def edit
    @todolist = TodoList.find(params[:id])
    if @todolist.user_id == current_user.id
      render :edit
    else
      redirect_to todo_lists_url
    end
  end

  def update
    @todolist = TodoList.find(params[:id])
    if (@todolist.user_id == current_user.id) && @todolist.update(list_params)
      redirect_to todo_list_url(@todolist)
    else
      flash[:errors] = @todolist.errors.full_messages
      render :edit
    end
  end

  def new
    @todolist = TodoList.new
  end

  def create
    @todolist = TodoList.new(list_params)
    @todolist.user_id = current_user.id
    if @todolist.save
      redirect_to todo_list_url(@todolist)
    else
      flash[:errors] = @todolist.errors.full_messages
      render :new
    end
  end

  def list_params
    params.require(:todo_list).permit(:name, :description, :user_id)
  end

end
