class ApplicationController < ActionController::Base
    include Pagy::Backend
    helper_method :current_user, :logged_in?, :current_admin, :admin_logged_in?

    def current_user
        @current_user ||=User.find_by_email(session[:email])
    end

    def logged_in?
        current_user != nil
    end

    def authorize_login
        if logged_in?
            redirect_to dashboard_users_path
        end
    end

    def authorize_logout
        if !logged_in?
            redirect_to login_users_path
        else
            @user = User.find_by(userid: session[:userid])
        end
    end

    #For Admin Authorization

    def current_admin
        @current_admin ||=session[:admin_logged_in]
    end

    def admin_logged_in?
        current_admin != nil
    end

    def admin_authorize_login
        if admin_logged_in?
            redirect_to dashboard_admin_index_path
        end
    end

    def admin_authorize_logout
        if !admin_logged_in?
            redirect_to login_admin_index_path
        end
    end
end
