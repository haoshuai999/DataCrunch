class DatacrunchesController < ApplicationController
    include DatacrunchesHelper
    
    def datacrunch_params
        params.require(:datacrunch).permit(:data, :title, :description)
    end
   
   
    def index
    end


   
    def create

        
        @datacrunch = Datacrunch.create!(datacrunch_params)
        puts @datacrunch.id

        flash[:notice] = "#{@datacrunch.data_file_name} was successfully uploaded. Check it out #{view_context.link_to('here', datacrunch_path(@datacrunch))}".html_safe
        # flash[:notice] = %Q[#{@datacrunch.data_file_name} was successfully uploaded.]
        redirect_to datacrunches_path
    end
    def new
    end
    def show
        @datacrunch = Datacrunch.find(params[:id]) # look up datacrunch by unique ID
        @file_path = display_file(@datacrunch)
    end

end
