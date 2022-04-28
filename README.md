# S&P500 index

This repo is used to find out the long run trends in the index value and the effect major recessions have had on it. I also build models to predict the long term interest rate along with the future price of the index.

It is organised as follows:

The inputs folder contains the data that we need for the report. There are two ways to get said data. The first is to download the data from the source, which is the website of the Economist Robert Schiller, who compiled the data. http://www.econ.yale.edu/~shiller/data.htm

Another way to get the data is included directly in the scripts folder, specifically in the cleaning_stock_market_data script. There is a link to a Json file that all you have to do is run and you will get all the data. The data is cleaned and organized in the script above to be able to be used in the report. There is another script that helps us create a simulated dataset that should resemble the final product of the data that we need.

The outputs folder contains the rmd and the pdf of the final report that we have. it also contains the cleaned dataset that is the output of the cleaning script.

There is another folder that is called interactivegraphforpriceofindex that contains a shiny application that we use to make an interactive graph. The folder contains the data necessary to be able to make the application run.