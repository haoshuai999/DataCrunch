class DatacrunchesController < ApplicationController
    def index
        if !params[:username].nil?
            flash[:notice] = "#{params[:username]} becomes a new registered user for Datacrunch!"
        end
    end

    def create
        if request[:user]
            @username = request[:user][:username]
            @password = request[:user][:password]
            if User.where({ username: @username, password: @password }).size > 0
                redirect_to datacrunches_path(:user_login => @username)
            else
                flash[:notice] = "Cannot find the user!"
                redirect_to datacrunches_path
            end
        else
            @datacrunch = Datacrunch.create!(params[:datacrunch])
            puts params
            flash[:notice] = "#{@datacrunch.filename} was successfully uploaded."
            redirect_to datacrunches_path
        end
    end

    def new
    end

end
