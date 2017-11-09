class UserController < ApplicationController
    def index
        @users = User.all
        if session[:id]
            @email =User.find(session[:id]).email
        end
        
    end
    
    def new
    end
    
    def create
        require 'digest'
        @email = params[:email]
        @password = params[:password]
        hidden_password = Digest::MD5.hexdigest(@password)
        User.create(
            email: @email,
            password: hidden_password
            )
            
        redirect_to '/'
    end
    
    def modify
        id = params[:id]
        @user=User.find(id)
    end
    
    def update
        @id = params[:id]
        @email = params[:email]
        @password = params[:password]
        hidden_password = Digest::MD5.hexdigest(@password)
        
        user = User.find(@id)
        user.update(
            email: @email,
            password: hidden_password
            )
        redirect_to '/'
    end
    
    def destroy
        @id = params[:id]
        user = User.find(@id)
        user.destroy
        
        redirect_to '/'
    end
    
    
    def login_process
        require 'digest'
        
        if User.exists?(email: params[:email])
            user = User.find_by(email: params[:email])
            if user.password == Digest::MD5.hexdigest(params[:password])
                session[:id] = user.id
                redirect_to '/'
            end
        end
        
    end
        
    
end

