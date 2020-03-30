class DatacrunchesController < ApplicationController
    include DatacrunchesHelper
    
    def datacrunch_params
        params.require(:datacrunch).permit(:data, :title, :description, :publicity)
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

        @datacrunches = Datacrunch.where({ publicity: true })
        #@datacrunches = Datacrunch.all
        
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
            datacrunch_params[:username] = session[:user_login]
            @datacrunch = Datacrunch.create!(datacrunch_params.merge(username: session[:username]))

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
            if params[:search]
                @search_keyword = params[:search].downcase
                @datacrunches = @datacrunches.where("lower(title) LIKE :search OR lower(description) LIKE :search", search: "%#{@search_keyword}%")
                if @datacrunches.empty?
                    flash[:notice] = "Cannot find what you want"
                end
                flash.discard
            end
        else
            @datacrunches = Datacrunch.all
        end
    
    def edit
        @datacrunches = Datacrunch.find(params[:id])
    end

    def update
        @datacrunches = Datacrunch.find(params[:id])
        @datacrunches.update_attributes!(datacrunch_params)
        flash[:notice] = "Datacrunch '#{@datacrunches.title}' was successfully updated."
        redirect_to datacrunches_showall_path
    end

    def destroy
        # puts "hello"
        @datacrunches = Datacrunch.find(params[:id])
        @datacrunches.destroy
        flash[:notice] = "Datacrunch '#{@datacrunches.title}' deleted."
        redirect_to datacrunches_showall_path
    end

    end

end
