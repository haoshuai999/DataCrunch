class DatacrunchesController < ApplicationController
    include DatacrunchesHelper
    require "#{Rails.root}/lib/dataframe.rb"
   
    
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

            flash[:notice] = "#{@datacrunch.data_file_name} was successfully uploaded. Check it out #{view_context.link_to('here', datacrunch_path(@datacrunch), :id => "view_data", :method => "get")}".html_safe
            # flash[:notice] = %Q[#{@datacrunch.data_file_name} was successfully uploaded.]
            redirect_to datacrunches_path
        end
    end

    def new
    end

    def show
        #flash is used here because it's accessible haml-side, there may be a more elegant way of doing this
        if params[:cols] == nil
            flash[:cols] = 10
        else
            flash[:cols] = params[:cols].to_i
        end
        if params[:rows] == nil
            flash[:rows] = 10
        else 
            flash[:rows] = params[:rows].to_i
        end

        @datacrunch = Datacrunch.find(params[:id]) # look up datacrunch by unique ID
        # @data = display_file(@datacrunch, flash[:cols], flash[:rows]) #Returns as a csv, flash messages denote dimensions of the data to display
        @dataSize = calc_datacrunch_size(@datacrunch.data_file_size) #Return a formatted file size 
    
        @dataframe = Dataframe.new(@datacrunch) #creates workable df from datacruch record
        @display_dataframe = @dataframe.limit(flash[:cols], flash[:rows]) #establishes limited dataframe for display
        # puts @dataframe.dataframe[0..2].inspect
        @dataDimensions = "#{@dataframe.ncols} columns and #{@dataframe.nrows} rows" #returns shape of full dataframe
        @data_json = @dataframe.dataframe.to_json
        response = {:data_json => @data_json, :columnname => session[:colname] }
        respond_to do |format|
            format.html
            format.json { render :json => response}
        end

    

    def colstats
        @datacrunch = Datacrunch.find(params[:id])
        @dataframe = Dataframe.new(@datacrunch)
        @columnname = params[:colname]
        @stats_vector = @dataframe.describe(params[:colname])
        
        session[:colname] = params[:colname]

        respond_to do |format|
            format.html
            format.js
        end
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
    
        @datacrunches = Datacrunch.find(params[:id])
        @datacrunches.destroy
        flash[:notice] = "Datacrunch '#{@datacrunches.title}' deleted."
        redirect_to datacrunches_showall_path
    end

end
