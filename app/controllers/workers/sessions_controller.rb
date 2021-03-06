# frozen_string_literal: true

class Workers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  prepend_before_action :require_no_authentication, only: [:new]
  before_action :authenticate_worker_login, only: [:create]
  # GET /resource/sign_in
  def new
    @worker = Worker.new
  end

  # POST /resource/sign_in
  def create
    super
    flash[:notice] = 'ログインしました！'
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected
  private

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def require_no_authentication
    # 会社と社員がログインしている場合を一度判定。
    if company_signed_in? && worker_signed_in?
      # ログインしている社員が、ログインしている会社に所属しているなら、アプリTOPページへ飛ばす。
      if current_company.id == current_worker.company_id
        redirect_to app_tops_path and return
      else
        # 社員のログイン画面で、会社の社員でないと、
        # その会社のアプリにログインできない制限をかけているので、
        # ここにくることはありえないが、念の為のエラーハンドリングで
        # root_pathの処理を設定している。
        redirect_to root_path and return
      end
      # すでに会社のみログイン済であれば、社員登録画面へ行く。
    elsif company_signed_in?
      return
    else
      redirect_to root_path and return
    end
  end

  # ログインする前の処理
  def authenticate_worker_login
    # アクションを起こす前(ログイン処理をする前に)emailを元に、
    # 社員の登録情報を取得する。ちなみにcurrent_worker.idではログインしていないので取得できない。emailではない場合は違うカラムを用意する。
    # また、paramsの動きが変わっていたので、型に合わせて、
    # 取得方法を入れ替えている。
    worker_login_id_params = if params.class == ActionController::Parameters
                               params[:worker][:worker_login_id]
                             else
                               params[:worker_login_id]
                             end
    @worker = Worker.find_by(worker_login_id: worker_login_id_params)
    # 社員情報が登録されているか判定する
    if @worker
      # 「会社でログイン」かつ「ログインしている会社のID」と「ログインしている社員の会社のID」が一致する場合には、処理を抜け、ログイン処理を行う。
      if company_signed_in? && current_company.id == @worker.company_id
        nil
        # 違う会社の社員であれば、エラーハンドリングを行えるようにして、
        # ログイン画面にレンダリングを行う。 and returnでエラー防止。
        # @で入力値を保管していない為注意が必要。
      elsif company_signed_in? && current_company.id != @worker.company_id
        # flash[:notice] = '他社社員です。(該当する社員情報はありません！)'
        # 上記が状況の映し出し。
        flash[:notice] = '該当する社員情報はありません。'
        @worker = Worker.new(worker_login_id: worker_login_id_params)
        redirect_to new_worker_session_path and return
      end
    else
      # 社員登録情報が見つからない場合には、
      # 入力情報を保持させるためにemailのみを持ったインスタンスを作成して、
      # エラーハンドリング表示を行えるようにする
      @worker = Worker.new(worker_login_id: worker_login_id_params)
      flash.now[:notice] = '該当する社員情報はありません。'
      render :new and return
    end
  end

  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    app_tops_path(resource)
  end

  # ログアウト後の遷移先
  def after_sign_out_path_for(resource)
    new_worker_session_path(resource)
  end
end
