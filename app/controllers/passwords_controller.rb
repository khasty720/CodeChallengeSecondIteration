class PasswordsController < ApplicationController
  def index
    @passwords = Password.all
  end

  def import
    Password.import(params[:input])
    redirect_to passwords_path, notice: "Password file imported succesfully."
  end
end
