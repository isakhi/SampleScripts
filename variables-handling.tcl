#**************
#  Upvar      #
#**************
#Upvar is used when we have to change the value of a variable from inside a procedure’s scope

proc example {one two} {
upvar $one local1
upvar $two local2

set local1 Imal
set local2 Sakhi

}

#in order to define several varialbe at once you can create a list and then use the foreach command to assign members of the list to a variable.
#below we definea list that has two items, then with foreach command we assign the list items to fname and lname variables respectively
set list {David Beckham}
foreach {fname lname} $list {}

puts "Before calling proc:\n Fname: $fname Lname: $lname"

example fname lname
puts "After calling proc:\n Fname: $fname Lname: $lname"

#**************
#  Global     #
#**************
#Each procedure in TCL has a local scope for variables. But you can use the 'global' command in a procedure to access global variables.
#declaring a global variable NAME and setting the value equal to TCL
global NAME
set NAME TCL
puts "\nValue of global variable NAME: $NAME\n"

#the below proc changes the global NAME variable value
proc changename {} {
	global NAME
	set NAME TCL/TK
}

changename

puts "Value of global variable NAME after changename proc: $NAME\n"

#**************
#  Eval       #
#**************
#One difference between Tcl and most other compilers is that Tcl will allow an executing program to create new commands and execute them while running.
#A tcl command is defined as a list of strings in which the first string is a command or proc. Any string or list which meets this criteria can be evaluated and executed.
#The eval command will evaluate a list of strings as though they were commands typed at the % prompt or sourced from a file. The eval command normally returns the final value of the commands being evaluated. If the commands being evaluated throw an error (for example, if there is a syntax error in one of the strings), then eval will will throw an error.
#Note that either concat or list may be used to create the command string, but that these two commands will create slightly different command strings.
#Eg: eval arg1 ??arg2?? ... ??argn??
#Evaluates arg1 - argn as one or more Tcl commands. The args are concatenated into a string, and passed to tcl_Eval to evaluate and execute.
#Eval returns the result (or error code) of that evaluation.

set pudding {rolypolymiddle jam}
eval set $pudding; #the eval command will evaluate pudding variable and will set thus set the value of rolypolymiddle equal to jam 
puts "In rolypoly we have $rolypolymiddle"

set test_var Te5T
set cmd {puts "Value of test_var: $test_var"}

puts "CMD IS: \'$cmd\'"
eval $cmd; #this will evaluate the cmd varialbe so it will execute the puts command and will print out the statement to STDOUT
