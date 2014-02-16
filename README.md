Autocomplete
============

##Read Me


There are two ways to use AutoComplete.

The first way is to use CLMAutoCompleteTextView straightout of the box. It gives you the ability to customize the search algorithm and the cells being displayed for the search results.

The second way is to create your own UITextView subclass or subclass CLMAutoCompleteTextView and hook up all the delegate and datasource calls CLMAutoCompleteView uses. The methods you must hook up deal with asking for the results to be displayed, customizing appearence, and handling the selection of a result. 
