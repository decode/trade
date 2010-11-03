class ApplicationController < ActionController::Base
  rescue_from 'Acl9::AccessDenied', :with => :access_denied

  protect_from_forgery

  helper_method :current_user_session, :current_user

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to users_url # TODO: change this to the main page
        return false
      end
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    def access_denied
      if current_user
        # It's presumed you have a template with words of pity and regret
        # for unhappy user who is not authorized to do what he wanted
        render :template => 'site/access_denied'
      else
        # In this case user has not even logged in. Might be OK after login.
        flash[:notice] = 'Access denied. Try to log in first.'
        redirect_to login_path
      end
    end

end
