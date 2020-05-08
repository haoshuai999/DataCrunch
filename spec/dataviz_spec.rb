require 'rails_helper'

describe DatacrunchesController do
    describe 'process data for barcharts and histograms' do
        before :each do
            @file_path = File.join Rails.root, 'spec/fixtures/files/wine-data.csv'
            @dataframe = Daru::DataFrame.read_csv(@file_path, liberal_parsing: true)
        end

        it 'convert continuous vector to json' do
            @columnvector = @dataframe["points"]
            @continuous = Datacrunch.process_continous(@columnvector)
            expect(@continuous).to be_an_instance_of(Array)
            expect(@continuous[0][:points]).to eq(87)
            expect(@continuous.length).to eq(287)
        end

        it 'categorical data with more than 10 unique values' do
            @columnvector = @dataframe["province"]
            @categorical = Datacrunch.process_categorical(@dataframe, @columnvector)
            expect(@categorical).to be_an_instance_of(Array)
            expect(@categorical[0][:freq]).to eq(82)
            expect(@categorical[0][:column]).to eq("California")
            expect(@categorical[-1][:freq]).to eq(102)
            expect(@categorical[-1][:column]).to eq("Other values")
            expect(@categorical.length).to eq(11)
        end

        it 'categorical data with missing values' do
            @columnvector = @dataframe["region_2"]
            @categorical = Datacrunch.process_categorical(@dataframe, @columnvector)
            expect(@categorical).to be_an_instance_of(Array)
            expect(@categorical[-2][:freq]).to eq(184)
            expect(@categorical[-2][:column]).to eq(:null)
            expect(@categorical.length).to eq(11)
        end

    end
end