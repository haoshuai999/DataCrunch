class DatacrunchesController < ApplicationController
    include DatacrunchesHelper
    require "#{Rails.root}/lib/dataframe.rb"
    require "#{Rails.root}/lib/counter.rb"
    
    def datacrunch_params
        params.require(:datacrunch).permit(:data, :title, :description, :publicity)
    end
   
   
    def index
        # Sign up as a new user
        if params[:newusername]
            session[:username] = params[:newusername]
            flash[:notice] = "#{params[:newusername]} is now a registered user for Datacrunch!"
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
        #Determines columns displayed
        params[:cols] == nil ||  params[:cols] < "10" ? (@ncols = 10) : (@ncols = params[:cols].to_i)
        params[:rows] == nil || params[:rows] < "10" ? (@nrows = 10) : (@nrows = params[:rows].to_i)

        @datacrunch = Datacrunch.find(params[:id]) # look up datacrunch by unique ID
       
        @dataSize = calc_datacrunch_size(@datacrunch.data_file_size) #Return a formatted file size 
        
        @datacrunch_file_path = get_datacrunch_path(@datacrunch)

        @dataframe = Dataframe.new(@datacrunch) #creates workable df from datacruch record
   
        
        @display_dataframe = @dataframe.limit(@ncols, @nrows) #establishes limited dataframe for display
        #Need to generate an additional dataframe with color scheme
        @stdev_df = @dataframe.gen_sdev_grid(@ncols, @nrows) #creates second dataframe with stdev values for each numerical column 
  
        @dataDimensions = "#{@dataframe.ncols} columns and #{@dataframe.nrows} rows" #returns shape of full dataframe
        # @data_json = @dataframe.dataframe.to_json

        begin
            @columnvector = @dataframe.dataframe[session[:colname]]
            @datatype = @columnvector.type
            @categorical = Datacrunch.process_categorical(@dataframe, @columnvector)
            @continuous = Datacrunch.process_continous(@columnvector)
        rescue
            
        end

        response = {:datatype => @datatype, :columnname => session[:colname], :categorical => @categorical, :continuous => @continuous}
        respond_to do |format|
            format.html
            format.json { render :json => response}
        end

    end

    def download
        datacrunch = Datacrunch.find(params[:id])
        datacrunch_file_path = get_datacrunch_path(datacrunch)
        send_file datacrunch_file_path, :disposition => 'attachment' #, x_sendfile: true
        # File.open(datacrunch_file_path, 'r') do |f|
        #     send_data f.read
        # end 
    end 

    def colstats
        @datacrunch = Datacrunch.find(params[:id])
        @dataframe = Dataframe.new(@datacrunch)
        @columnname = params[:colname]
        session[:colname] = params[:colname]

        @stats_vector = Datacrunch.describe_data(@dataframe, params[:colname])
        

        respond_to do |format|
            # The following line needs to be deleted after inplementing the RSpec test
            format.html { render :partial => "colstats"}
            format.js { render 'colstats'}
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
