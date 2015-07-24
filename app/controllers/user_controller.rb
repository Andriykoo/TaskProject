class UserController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin? , only: :show

  def index
    @user=set_user
  end

  def show
    @users=User.all
  end

  def edit
   # binding.pry
   unless set_user.nil?
     @user=set_user
   else
     flash[:alert]="Cannot find user!"
     redirect_to user_show_path
   end
  end

  def update
    @user = set_user

    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to user_show_path
    else
      render 'edit'
    end
  end


  def destroy
    @user = set_user
    binding.pry
    if @user.destroy
      flash[:success] = "User destroy"
      redirect_to user_show_path
    else
      flash[:error] = "User cannot destroy"
      redirect_to user_show_path
    end
  end

  def update_password
    @user = current_user
      if @user.update_with_password(user_password_params)
        sign_in @user, bypass: true
        redirect_to "index"
      else
        render 'edit_password'
      end

    end


  def edit_password
    @user=current_user
  end




  private
  def is_admin?
    # binding.pry

    if signed_in?
      flash[:alert] = 'Only admins allowed!' unless current_user.has_role? :admin
    else
      flash[:alert] = 'Please sign in!'
    end
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      return User.find_by(id: params[:id])
    end

  private
  def user_params
    params.require(:user).permit(:email, :name)
  end

  private
  def user_password_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

end
