class DatacrunchesController < ApplicationController
    include DatacrunchesHelper
    
    def datacrunch_params
        params.require(:datacrunch).permit(:data, :title, :description)
    end
   
   
    def index
        # Sign up as a new user
        if params[:newusername]
            session[:username] = params[:newusername]
            flash[:notice] = "#{params[:newusername]} becomes a new registered user for Datacrunch!"
        elsif params[:user_login]
            session[:username] = params[:user_login]
        elsif session[:username]
            params[:user_login] = session[:username]
        end

        if request[:commit] == "Log out"
            session.delete(:username)
            params[:user_login] = nil
        end
        
    end

    def create
        if request[:user]
            @username = request[:user][:username]
            @password = request[:user][:password]
            # puts User.all.size
            if User.where({ username: @username, password: @password }).size > 0
                redirect_to datacrunches_path(:user_login => @username)
            else
                flash[:notice] = "Cannot find the user!"
                redirect_to datacrunches_path
            end
        else
<<<<<<< HEAD
            @datacrunch = Datacrunch.create!(datacrunch_params)
            # puts @datacrunch.id
=======
            datacrunch_params[:username] = session[:user_login]
            @datacrunch = Datacrunch.create!(datacrunch_params.merge(username: session[:username]))
>>>>>>> shuaihao
    
            flash[:notice] = "#{@datacrunch.data_file_name} was successfully uploaded. Check it out #{view_context.link_to('here', datacrunch_path(@datacrunch), :id => "view_data")}".html_safe
            # flash[:notice] = %Q[#{@datacrunch.data_file_name} was successfully uploaded.]
            redirect_to datacrunches_path
        end
    end

    def new
    end

    def show
        @datacrunch = Datacrunch.find(params[:id]) # look up datacrunch by unique ID
        @data = display_file(@datacrunch)
    end

    def showall
        if session[:username]
            params[:user_login] = session[:username]
            @datacrunches = Datacrunch.where({ username: params[:user_login] })
            # if params[:search]
            #     search_keyword = @datacrunches.find_by(description: params[:search])
            #     if search_keyword
            #         @datacrunches = @datacrunches.where(description: params[:user_login])
            #     else
            #         flash[:notice] = "Cannot find what you want"
            #     end
            # end
        elsif
            @datacrunches = Datacrunch.all
        end
        
    end

end
