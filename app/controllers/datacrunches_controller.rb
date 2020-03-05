class DatacrunchesController < ApplicationController
    def index
        if !params[:username].nil?
            flash[:notice] = "#{params[:username]} becomes a new registered user for Datacrunch!"
        end
    end

    def create
        @datacrunch = Datacrunch.create!(params[:datacrunch])
        puts params
        flash[:notice] = "#{@datacrunch.filename} was successfully uploaded."
        redirect_to datacrunches_path
    end

    def new
    end

end
