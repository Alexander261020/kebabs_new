class UsersController < ApplicationController
  # Встроенный в девайз фильтр — посылает незалогиненного пользователя
  before_action :authenticate_user!, except: [:show]

  # Задаем объект @user для шаблонов и экшенов
  before_action :set_current_user, except: [:show]

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: I18n.t('controllers.users.updated')
    else
      render :edit
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
