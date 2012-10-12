Purpose
========

ExpenseLog is an easy way to record my spending. When it's convenient, I take all the receipts I've got in my wallet and record how I spent my money into a text file. 

This project is meant to serve as a to realize some of the compiler concepts I'm reading about.

Explanation
===============

In a text file, I'll type out the essential information from a receipt (using a specific syntax). Next, I'll run a parser which converts the text to an abstract syntax tree (doesn't do this, yet). Once I've converted several receipts to an AST, I can then use it to extract patterns about my spending habits.

Here's an example of what the contents of the text file look like.

<pre>
2012-12-23 @Macy's
    "t-shirt" 23.49 [clothes, gift]
    tax: 2.10
  @Burger King
    "Whopper Meal" 7.39 [fast food]
    tax: 0.73
  @
    "hot dog" 1.99 *

2012-12-24
  @Shell
    "gas" 30 [auto, gas]
    "gum" 1.20 [candy]
    tax: 3 
	@
		5
</pre>


Input File Specification
===================

Start each days worth of expenses by the date (yyyy-mm-dd) on it's own line.

A date must be followed by at least one expense.

An expense has three parts: the location, the items purchased at that location, and sales taxes. The location part is indented once. The item purchased part is indented twice, as well as the tax part. 

Here's an example:

<pre>
2012-12-24                   // date
	@Sell                      // location
		"gas" 30 [auto, gas]     // item purchased
		"gum" 1.20 [candy]
		tax: 3                   // sales tax
</pre>

The location must have an @ sign, may have a name, must be indented, and must be on it's own line.

An item has three parts elements to it: a description, an amount, and a tag list.

The description part is optional. It you choose to include it, then you must surround the description with double quotes and it must be the first element in the item line. 

The amount is required for each item line. The item is a positive integer or a decimal with at most two decimal places.

The list tag is optional. If you include it, then it must be surrounded by open-close brackets and the tags must be delimited by commas.

In place of a tag list, you may substitute a * sign. This will indicate to the parser that the tag list for the current line is same as the tag list from the previous line.

Here are several examples of what an item can look like:

<pre>
"t-shirt" 23.49 [clothes, gift]
23.49 [clothes, gift]
23.49 *
23.49
</pre>


If you choose to track the sales tax of an expense, then precede the tax amount with "tax: ". Do not provide a description or a tags list.

Here's an example:

<pre>
tax: 3 
</pre>

In place of an amount you may add an expression. By expression, I mean series of addition, subtraction, multiplication, and division operation on amounts. This expression must be surround the greater than and less than sign.

Heres an example of it being used in an item line:

<pre>
"pizza for dinner" >2*9.99< [eat out, cheat meal]
</pre>

The parser will substitute the expression with the total value for the expression.


Ideas for 2.0 version
======================


If you only have a very few expense to log, then you can simply log them on the command line. 

<pre>
2043-12-23 @Rosie's Place "dinner" 30 [fast food] 
2043-12-23 30 [fast food]
2043-12-23 5 [fast food]
YESTERDAY 5 [fast food]
</pre>

Or use a more conversational form:
<pre>
SPENT 30 @ Rosie's Place FOR "dinner" [fast food]   //assumes it was today
SPENT $30 AT Rosie's Place FOR dinner [fast food]
SPENT 30$ AT Shell ON gas [auto, gas]
SPENT 1.20 AT Shell ON gum [auto, gas]
SPENT 3 AT Shell ON tax
SPENT 3
YESTERDAY SPENT 7.39 AT Burger King FOR A whopper meal [fast food]
</pre>


Create charts to visualize expenses:
* a pie of last 3 months expenses.
* a pie chart of this years expenses.
* a pie chart of the different categories (tags) I've spent on

Create a syntax highlighter:
* Vim
* Emacs
* Sublime Text 2
