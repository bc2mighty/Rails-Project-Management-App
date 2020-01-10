class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

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
end
