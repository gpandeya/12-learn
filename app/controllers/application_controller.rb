class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :get_user, :log_auth
  

  private
  
  def log_auth
    data ={uid: nil, email: nil, role: nil, controller: controller_name, action: action_name, params: request.params.to_h, time: Time.now}
    data= data.merge ({uid: @user.id, email: @user.email, role: @user.role}) if @user
    #final =data.merge(user)
    ap data
  end
  

  def get_user
    @user = current_user
    @is_logged_in = user_signed_in?
    @is_student = @is_logged_in && @user.role == 'student'
    @is_teacher = @is_logged_in && @user.role == 'teacher'
  end

  def auth_teacher
    redirect_to root_url if !@is_teacher
  end

  def auth_student
    redirect_to root_url if !@is_student
  end

end
