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
    render html: '403 El método de autenticación fallo. Para soporte acerca de este error favor de contactar a soporte@cimav.edu.mx'.html_safe, :status => 403
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end
end
