class PasswordsController < ApplicationController
  before_action :set_password, only: [:destroy, :edit, :update]
  before_action :authenticate

  def index
    @passwords = Password.all
    @password = Password.new
  end

  def destroy
    @password.destroy
    respond_to do |format|
      format.html { redirect_to passwords_path, notice: 'Password was successfully removed.' }
    end
  end

  def import
    Password.import(params[:input])
    redirect_to passwords_path, notice: "Password file imported succesfully."
  end

  def new
      @password = Password.new
  end

  def edit

  end

  def update
    respond_to do |format|
      if @password.update(password_params)
        #Change
        @password.test
        format.html { redirect_to passwords_path, notice: 'Password was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def create
    @password = Password.new(password_params)
    respond_to do |format|
      if @password.save
        #Change
        @password.test
        format.html { redirect_to passwords_path, notice: 'Password was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end


  private
    def set_password
      @password = Password.find(params[:id])
    end

    def password_params
      params.require(:password).permit(:name, :val_password)
    end
end
