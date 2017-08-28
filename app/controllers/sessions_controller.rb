class SessionsController < ApplicationController
  def create
    session[:user_email] = auth_hash['info']['email']

    if authenticated?
      redirect_to '/'
    else
      @title = "Error 401" 
      @message = "El usuario no está autorizado para utilizar esta aplicación."
      render layout: 'standalone', template: 'application/error', :status => 401
    end
  end

  def destroy
    reset_session
    redirect_to '/login'
  end

  def failure
    @title = "Error 403" 
    @message = "El método de autenticación falló."
    render layout: 'standalone', template: 'application/error', :status => 403
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end
end
