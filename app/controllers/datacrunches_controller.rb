class DatacrunchesController < ApplicationController
    def index
    end
    def create
        # @datacrunch = Datacrunch.create!(params[:datacrunch])
        
        @file = params[:Upload]
        
        puts params[:datacrunch]
        puts @file

        flash[:notice] = "#{@file.original_filename} was successfully uploaded."
        redirect_to datacrunches_path
    end
    def new
    end

end
