class DatacrunchesController < ApplicationController
    def index
    end
    def create
        # @datacrunch = Datacrunch.create!(params[:datacrunch])
        
        @record_parameters = params[:datacrunch]
        @file = params[:Upload]
        @record_parameters[:filename] = @file.original_filename
        
        puts @record_parameters

        flash[:notice] = "#{@file.original_filename} was successfully uploaded."
        redirect_to datacrunches_path
    end
    def new
    end

end
