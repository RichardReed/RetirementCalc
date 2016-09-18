Updated 6/23/2016
OVERVIEW
At this time, this program is very specific, for my retirement.  However I hope to make it more generic in the future.  Program assumes the person is 60 or over.
	
TO USE
Fill out the parameters in the lib/Config.yml file.

Some final results are displayed.  All the final results are recorded in the Results.yml file.
 
OPTIONS TO RUN
MoneyRanOut.rb - Calculates the year the sum of IRA savings and Non IRA savings is < 0

LastYearWithMoney.rb - Calculates the year prior to running out of money  

RetCalc.rb - Calculates the state of retirement funds for a specific year

CsvResults.rb - Places the results of specific parameters into a csv file for the specified year range.  These can be put into a spread sheet and graphed.

CALCULATIONS
Taxrate is income + IRA Spending, based on the IRA tax tables for Married filing jointly, assuming standard deductions.  These are in the Config.yml file and may be changed.

If in a specific year, income > expenses, the excess goes into non-IRA savings. (No savings goes into the IRA savings.)

If in a specific year, expenses > income, the shortfall is withdrawn from IRA savings. The exception is that money to pay income_tax is withdrawn from non-IRA savings.

A set amount is transferred from IRA to non-IRA each year.  This is taxed and the taxes are withdrawn from the non-IRA along with other income taxes.  I adjusted this money so both IRA and non-IRA funds to run out the same year.

non-IRA interest is reduced by an amount specified in the Config.yml file (15%) to adjust for income taxes.

TESTING
Ruby unit testing is based on the results from numbers run through TestCalculations.xlsx with the values in test/Config.yml.  Accepted program results are within +/- $2 of the spread sheet.

Rspec testing is run on each calculation method using mocks for the Config.yml values.  Code coverage is at 100% calculated by SimpleCov.
