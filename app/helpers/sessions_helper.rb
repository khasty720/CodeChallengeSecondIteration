module SessionsHelper

  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def user_signed_in
    if current_user
      return true
    else
      return false
    end
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end

end
