class ProfileController < ApplicationController
  before_filter :require_login

  def edit
    @user = current_user
    @password_form = PasswordChangeForm.new
  end

  def update
    @user = current_user
    @password_form = PasswordChangeForm.new
    @user.assign_attributes user_permited_params

    if @user.save
      render action: :edit, gflash: {error: t('gflash.profile_errors')}
    else
      redirect_to edit_profile_url, gflash: {notice: t('gflash.profile_update')}
    end
  end

  def change_password
    @user = current_user
    @password_form = PasswordChangeForm.new(password_permited_params)

    if @password_form.valid?
      @user.change_password!(@password_form.password)
      redirect_to edit_profile_url, gflash: { notice: t('devise.passwords.updated_succcess') }
    else
      render action: :edit, gflash: { error: t('gflash.profile_errors') }
    end
  end

  private

  def user_permited_params
    params.require(:user).permit(:name, :pivotal_person_id, :email, :subscribed)
  end

  def password_permited_params
    params.require(:password_change_form).permit(:password, :password_confirmation)
  end
end
