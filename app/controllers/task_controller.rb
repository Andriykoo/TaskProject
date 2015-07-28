class TaskController < ApplicationController
  before_filter :authenticate_user!
  def show

    @tasks= Task.all
    @tasks=@tasks.uniq! {|p| p[:title] }
  end

  def new
    if Add_task_for_user_email(task_params,params[:email])
      flash[:success] = "Add new task and user will get that for email"
      redirect_to task_show_path
    else
      render 'add'
    end
  end

  def show_task_user
    @tasks=Task.where(user_id: params[:id])
    render 'show'
  end

  def edit
     if set_task.nil?
        flash[:alert]="Cannot find task in DB!"
        redirect_to task_show_path
     else
        @task=set_task
     end
  end

  def update
    @task = set_task
    if @task.update(task_params)
      flash[:success] = "Task updated"
        redirect_to task_show_path
    else
      render 'edit'
    end
  end


  def destroy
    @task = set_task
    if @task.destroy
      flash[:success] = "Task destroy"
      redirect_to task_show_path
    else
      flash[:error] = "Task cannot be destroyd"
      redirect_to task_show_path
    end
  end

  def share
    @task_id=params[:id]
  end

  def share_for_user
    binding.pry


    binding.pry
    if Add_task_for_user_email({title:set_task.title,text:set_task.text},params[:email])
      @share_task= ShareTask.new(task_id:params[:id] ,user_id: current_user.id)
      flash[:success] = "Task will share and get that for email"
      redirect_to task_show_path
    else
      redirect_to task_show_path
    end
  end


  private
  def task_params(task={})
      params.require(:task).permit(:title,:text)
  end

  private
  def Add_task_for_user_email(params,email)
    @user=User.find_by(email:email.values)
    unless @user.nil?
      @task=Task.new(title: params[:title],text: params[:text],user_id:@user.id)
      if !@user.has_task? @task
        flash[:error] = "User has this task"
        return false
      end
      if @task.save
        TaskMailer.new_task_mail(@user,current_user).deliver
        return true
      else
        return false
      end

    else
      flash[:error] = "Cannot find user with this email"
      return false
    end
  end


  private
  def set_task
    @task=Task.find_by(id:params[:id])
  end


end






