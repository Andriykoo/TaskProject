class TaskController < ApplicationController
  before_filter :authenticate_user!
  def show
    @tasks= Task.all
  end

  def new
    if Add_task_for_user_email(task_params,params[:email])
      flash[:success] = "Add new task"
      redirect_to task_show_path
    else
      render 'add'
    end
  end

    def show_task_user
      @tasks=Task.where(user_id: params[:id])
      render 'show'
    end





end






private
def task_params
  params.require(:task).permit(:title,:text)
end

private
def Add_task_for_user_email(params,email)
  @user=User.all.find_by(email:email.values)
  binding.pry
  unless @user.nil?
      @task=Task.new(title: params[:title],user_id:@user.id)
      binding.pry
      return @task.save
  else
    flash.now[:error] = "Cannot find user with this email"
    return false
  end
end