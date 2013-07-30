OVERVIEW
	At this time, this program is very specific, for my retirement.  However I hope to make it more generic in the future.
	
HOW TO USE
	To find out the year the sum of IRA savings and Non IRA savings is < 0, run MoneyRanOut.rb
	To find out the year prior to running out of money, run LastYearWithMoney.rb 
	To get the summary of retirement funds for a specific year, run RetCalc.rb
	Information from the last run is stored in Results.yml and displayed on command line
	All income, expenses, starting savings, interest rates, etc are in Config.yml

CALCULATIONS
Taxrate is based on (income + IRA Spending) as follows:
	< $19,000:          0
	$19,000 - $36,000:  10%
	$36,000 - $88,000:  $1700 + 15% * income over $36,000
	> $88,000:          $9500 + 25% * income over $88,000
	
	The brackets include the standard deduction plus a single dependent.

Before age 60, all excess expenses or savings come out of or go into non-IRA.

Age 60 and after, if income > expenses, the excess goes into non-IRA.

Age 60 and after, if expenses > income, the shortfall is withdrawn from IRA. The exception is that money to pay income_tax is withdrawn from non-IRA savings.

Age 60 and after, a set amount is transferred from IRA to non-IRA each year.  This is taxed and the taxes are withdrawn from the non-IRA along with other income taxes.  This money should be adjusted to so both IRA and non-IRA funds to run out the same year.

No Savings goes into the IRA account -> Any savings goes to non-IRA 

TESTING
	Testing is based on the results from numbers run through TestCalculations.xlsx.  Provided the program results are within +/- $2 of the spread sheet, I consider the program correct.

BUGS
The IRA Account value is off by $3 at age 72, which increases to $64 at age 92.  There is probably a bug causing this, but the small amount has a neglegable affect on the results.





