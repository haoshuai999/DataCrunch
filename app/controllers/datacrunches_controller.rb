class DatacrunchesController < ApplicationController
    include DatacrunchesHelper
    
    def datacrunch_params
        params.require(:datacrunch).permit(:data, :title, :description)
    end
   
   
    def index
        if !params[:username].nil?
            session[:username] = params[:username]
            flash[:notice] = "#{params[:username]} becomes a new registered user for Datacrunch!"
        end
    end

    def create
        if request[:user]
            @username = request[:user][:username]
            @password = request[:user][:password]
            puts User.all.size
            if User.where({ username: @username, password: @password }).size > 0
                redirect_to datacrunches_path(:user_login => @username)
            else
                flash[:notice] = "Cannot find the user!"
                redirect_to datacrunches_path
            end
        else
            @datacrunch = Datacrunch.create!(datacrunch_params)
            puts @datacrunch.id
    
            flash[:notice] = "#{@datacrunch.data_file_name} was successfully uploaded. Check it out #{view_context.link_to('here', datacrunch_path(@datacrunch))}".html_safe
            # flash[:notice] = %Q[#{@datacrunch.data_file_name} was successfully uploaded.]
            redirect_to datacrunches_path
        end
    end

    def new
    end
    def show
        @datacrunch = Datacrunch.find(params[:id]) # look up datacrunch by unique ID
        @file_path = display_file(@datacrunch)
    end

end
