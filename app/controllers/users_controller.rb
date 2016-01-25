class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  def index
    @users = User.all
  end

  def new
    @user = User.new
  end


  def edit
  end

  def login
    @user = User.new
  end

  def generate_password
    @user = User.new
    @user.generate_password
  end

  def email
  end

  def send_email
    if User.exists?(email: params[:email])
      @user = User.find_by email: params[:email]

      #Send Email
      UserMailer.emergency_contact_email(@user).deliver_later
      redirect_to login_path, notice: 'Account info sent to Emergency Contact.'
    else
      #Email not found
      redirect_to email_users_path, alert: 'Emergency Contact not found.'
    end
  end


  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_user_path(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :password, :email, :score)
    end
end
