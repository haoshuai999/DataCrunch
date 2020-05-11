# Data Crunch: know your data

Team members: Aaron Brezel (ab4717) and Shuai Hao (sh3831)

## [Link](https://calm-garden-33614.herokuapp.com/)

### What is DataCrunch?

DataCrunch is a website dedicated towards simplifying data analysis. 

Its developers, Shuai Hao and Aaron Brezel are journalists as well as engineers. During their time working in newsrooms, they noticed how many good reporters struggled to work with data. That's because They were being overserved by complex tools like Excel and Tableau. Too many options and not enough guidance. 

That's where DataCrunch comes in. It's designed to make data analysis as simple as possible. All users need to do is upload the file they want to analyze. Currently we support csvs, excel workbooks and json files. DataCrunch does all the processing for you and presents critical data like a column-by-column statistical breakdown. 

With DataCrunch, there's no code, no confusing menus and no random clicking to find what you need. It's just the basics. Check it out. Understand your data. 

### Running the app

To run this app locally, clone this repo and navigate to the DataCrunch folder with your command line. With rails ~4.2 installed and a working postgresql server, run `rails server` to start the app.

To run all cucumber feature tests at the same time, run the command `rake cucumber features`. To test features individually, find the feature that you with to test in the /features directory. Then, you can run `rake cucumber features/[feature_name].feature`.

To run all RSpec tests at the same time, run the command `rake spec`. To run individual RSpec tests, find the test in the /spec directory and then run `rspec spec/[rspec_test_name].rb`.

### Pain points
In designing this website, we attempted to address the following painpoints:

* Time-consuming to find patterns in large datasets
* Very difficult for individuals with no prior data skills
* If you don’t know much about statistics, you might analyze incorrectly 
* Microsoft Excel struggles with large datasets

### Estimated Market Size
We made the following estimations when addressing our market size: 

* Our target audience is journalists who lack data literacy. There are roughly 49,700 journalists currently working in the United States according to the Bureau of Labor Statistics.
* Our market could expand to encompass any individual looking to perform simple data analysis.
