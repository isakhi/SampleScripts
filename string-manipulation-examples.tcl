#Simple TCL script showing different string manipulations in TCL and a regex example in the end

proc reformat_int { context } {
    
	puts "Context: $context"
    # Split context
    set contextList [split $context /]
	
	puts "Contextlist $contextList"
    # Change base to 500
    set gemid [expr [lindex $contextList 2] + 500]
	puts "gemidTrouble: $gemid"
	
    # Assemble return string 1-1-1-501
    append contextgemid "1-" [lindex $contextList 0] "-" [lindex $contextList 1] "-" $gemid

    return $contextgemid
}

set test [reformat_int 1/1/1]
puts $test

#remove ont from interface name
set ifname 1/1/ont1
set ifname [string map {"ont" ""} $ifname]
puts $ifname

#proc that will do the substition based on the provided string and arguments where first and third
#arguments are taken as regex expressions and 2nd and 4th as the input strings

proc regex_map { str args } {
	
	puts "Args Length: [llength $args]"
    if { [llength $args] % 2 == 1} {
        set msg "wrong \# args: should be "
        append msg "regex value ?regex value?...\""
        return -code error $msg
    }
    
    foreach {regex value} $args {
		puts "Regex: $regex Value: $value"
        regsub -all $regex $str $value ret_str
    }
    
    return $ret_str
}

set sentence [regex_map "Cocacola tastes better than Fanta" {co+[^ ]} Sprite {better} worse]
puts $sentence

set whatever "when something &lt; then don't make it &gt;"

set bla [string map -nocase {
		"&lt;"      "<"
		"&gt;"      ">"
		"&le;"      "<="
		"&ge;"      ">="
		} $whatever]

puts $bla