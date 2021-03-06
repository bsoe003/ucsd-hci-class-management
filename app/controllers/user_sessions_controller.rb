class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password].upcase)
      if @user.is_student?
        if Time.now <= STUDIO_DUE && current_user.studio.nil?
          flash[:notice] = "Studio signup is due."
          redirect_to edit_student_path(current_user)
        else
          redirect_back_or_to(root_path, notice: 'Login successful')
        end
      else
        redirect_to assignments_submissions_path
      end
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: 'Logged out!')
  end
end