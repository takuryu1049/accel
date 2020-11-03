# frozen_string_literal: true

class Workers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  # 🔃  recapcha
  prepend_before_action :check_captcha, only: [:create]
  before_action :authenticate
  # GET /resource/sign_up
  def new
    @worker = Worker.new
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected
  private

  def check_captcha
    self.resource = resource_class.new sign_up_params
    resource.validate
    unless verify_recaptcha(model: resource)
      respond_with_navigational(resource) { render :new }
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
    # 😁  :passwordとpassword_confirmationは念のため渡しています
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:worker_login_id, :password,:password_confirmation, :email, :last_name,:first_name,:last_name_kana,:first_name_kana,:gender,:born,:character_id,:position_id,:qualification_id,:company_id,:image])
  end

  def authenticate
    redirect_to root_path unless company_signed_in?
  end

  def after_sign_up_path_for(resource)
    app_tops_path(resource)
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
