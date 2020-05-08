require 'rails_helper'

describe DatacrunchesController do
    describe 'process data for barcharts and histograms' do
        context 'large CSV file with more unique values' do
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

        context 'small CSV file with fewer unique values' do
            before :each do
                @file_path = File.join Rails.root, 'spec/fixtures/files/data.csv'
                @dataframe = Daru::DataFrame.read_csv(@file_path, liberal_parsing: true)
            end

            it 'categorical data with three unique values' do
                @columnvector = @dataframe["title"]
                @categorical = Datacrunch.process_categorical(@dataframe, @columnvector)
                expect(@categorical).to be_an_instance_of(Array)
                expect(@categorical[-1][:column]).not_to eq("Other values")
                expect(@categorical.length).to eq(3)
            end
        end

        context 'Large Excel file with missing values' do
            before :each do
                @file_path = File.join Rails.root, 'spec/fixtures/files/data.xlsx'
                @dataframe = Daru::DataFrame.read_excel(@file_path).call(sheet: 0)
            end

            it 'convert continuous vector to json' do
                @columnvector = @dataframe["num_comments"]
                @continuous = Datacrunch.process_continous(@columnvector)
                expect(@continuous).to be_an_instance_of(Array)
                expect(@continuous[0][:num_comments]).to eq(7)
                expect(@continuous.length).to eq(259)
            end

            it 'categorical data with more than 10 unique values' do
                @columnvector = @dataframe["author"]
                @categorical = Datacrunch.process_categorical(@dataframe, @columnvector)
                expect(@categorical).to be_an_instance_of(Array)
                expect(@categorical[0][:freq]).to eq(4)
                expect(@categorical[0][:column]).to eq("Blulien")
                expect(@categorical[-1][:freq]).to eq(230)
                expect(@categorical[-1][:column]).to eq("Other values")
                expect(@categorical.length).to eq(11)
            end

            it 'categorical data with five unique values' do
                @columnvector = @dataframe["subreddit"]
                @categorical = Datacrunch.process_categorical(@dataframe, @columnvector)
                expect(@categorical).to be_an_instance_of(Array)
                expect(@categorical[-1][:column]).not_to eq("Other values")
                expect(@categorical.length).to eq(5)
            end

            it 'categorical data with missing values' do
                @columnvector = @dataframe["is_self"]
                @categorical = Datacrunch.process_categorical(@dataframe, @columnvector)
                expect(@categorical).to be_an_instance_of(Array)
                expect(@categorical[1][:freq]).to eq(5)
                expect(@categorical[1][:column]).to eq(:null)
                expect(@categorical.length).to eq(2)
            end
        end

        context 'Large JSON file with missing values' do
            before :each do
                @file_path = File.join Rails.root, 'spec/fixtures/files/data.json'
                json_file = JSON.parse(File.open(@file_path).read)
                json_converter = JsonConverter.new
                csv_json = json_converter.generate_csv(json_file)
                
                csv = CSV.parse(csv_json, headers: true, converters: %i[numeric date])
                
                @dataframe = Daru::DataFrame.rows(csv.to_a[1..-1], order: csv.headers)
            end

            it 'convert continuous vector to json' do
                @columnvector = @dataframe["Funding.Request"]
                @continuous = Datacrunch.process_continous(@columnvector)
                expect(@continuous).to be_an_instance_of(Array)
                expect(@continuous[0][:Funding][:Request]).to eq(70156877)
                expect(@continuous.length).to eq(15)
            end

            it 'categorical data with more than 10 unique values' do
                @columnvector = @dataframe["Applicant.Name"]
                @categorical = Datacrunch.process_categorical(@dataframe, @columnvector)
                expect(@categorical).to be_an_instance_of(Array)
                expect(@categorical[0][:freq]).to eq(2)
                expect(@categorical[0][:column]).to eq("Florida Department of Transportation")
                expect(@categorical[-1][:freq]).to eq(4)
                expect(@categorical[-1][:column]).to eq("Other values")
                expect(@categorical.length).to eq(11)
            end

            it 'categorical data with two unique values' do
                @columnvector = @dataframe["Awardee"]
                @categorical = Datacrunch.process_categorical(@dataframe, @columnvector)
                expect(@categorical).to be_an_instance_of(Array)
                expect(@categorical[-1][:column]).not_to eq("Other values")
                expect(@categorical.length).to eq(2)
            end

            it 'categorical data with missing values' do
                @columnvector = @dataframe["President"]
                @categorical = Datacrunch.process_categorical(@dataframe, @columnvector)
                expect(@categorical).to be_an_instance_of(Array)
                expect(@categorical[-1][:freq]).to eq(1)
                # The following test is not ideal, because the label for missing values should be null
                expect(@categorical[-1][:column]).to eq("")
                expect(@categorical.length).to eq(3)
            end
        end
    end
end