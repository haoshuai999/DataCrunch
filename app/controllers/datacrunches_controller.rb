class DatacrunchesController < ApplicationController
    def index
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
