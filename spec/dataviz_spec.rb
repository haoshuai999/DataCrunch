require 'rails_helper'

describe DatacrunchesController do
    describe 'show continuous data using histogram' do
        context 'no missing data' do
            before :each do
                @file_path = File.join Rails.root, 'spec/fixtures/files/wine-data.csv'
                # @datacrunch = FactoryGirl.create(:datacrunch)
                @dataframe = Daru::DataFrame.read_csv(@file_path, liberal_parsing: true)
                @columnvector = @dataframe["points"]
            end
    
            it 'convert vector to json' do
                @continuous = Datacrunch.process_continous(@columnvector)
                expect(@continuous).to be_an_instance_of(Array)
                expect(@continuous[0][:points]).to eq(87)
                expect(@continuous.length).to eq(287)
            end

            # it '' do
            # end

            # it '' do
            # end
        end
    end
end