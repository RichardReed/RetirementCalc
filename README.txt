OVERVIEW
	At this time, this program is very specific, for my retirement.  However I hope to make it more generic in the future.
	
HOW TO USE
	To find out the year the sum of IRA savings and Non IRA savings is < 0, run MoneyRanOut.rb
	To get the summary of retirement funds for a specific year, run RetCalc.rb
	Information from the last run is storred in Results.yml file

TO DO
- MoneyRunOut.rb, print out last year before money runs out not year that money ran out
- Allow changes to Expenses when moving to the retirement home and into assisted living
- Create a menu for selecting the option
- Create option to cycle through each year with results going into a spread sheet
- Change the opening and writing of the yml files to use blocks.  Programming Ruby Version 2 pg 50, 51
- Put into GitHub
- Add error handling
- Add a UI interface for input and output

CALCULATIONS
Taxrate is based on income + IRA Spending as follows:
	< $19,000:          0
	$19,000 - $36,000:  10%
	$36,000 - $88,000:  $1700 + 15% * income over $36,000
	> $88,000:          $9500 + 25% * income over $88,000

Before age 60, all excess expenses or savings come out of or go into non-IRA.

Age 60 and after, all income > expenses goes into non-IRA.

Age 60 and after, all expenses > income are withdrawn from IRA, except income_tax is withdrawn from non-IRA savings

Age 60 and after, a set amount is transferred from IRA to non-IRA each year.  This is taxed and withdrawn from non-IRA with other income taxes.

Gross_Income = Improving_income + Navy_pension + GE_pension + Alcatel_pension + SS + IRA Spending

IRA_spend = Gross_income - gross_expenses (IRA_spend is always 0 or a negative value)

IRA_Account = last_years_IRA_Account + IRA_Spend_Save - last_years_non-IRA_Account(if < 0)

No IRA Savings -> Any savings goes to non-IRA savings

Income_tax = (improving_income * (tax_rate + 7.65%)) + ((GE_pension + Alcatel_Pension + SS + Navy_pension + IRA_spending) * tax_rate)

non-IRA_Account = non-IRA_account - Income_taxes

TESTING
	Testing is based on fictious numbers run through TestCalculations.xlsx.  Provided the program results are within + or - $1 of the spread sheet, I considered the answers correct.





