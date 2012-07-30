#
# OS Compatiblity functions
#


function c_on_a_mac(){
	OS=$(uname)
	MAC="Darwin"
	
	if [ "$OS" = "$MAC" ]; then
		return "1"
	fi
	return "0"
}

function c_dont_run_on_mac() {
	on_mac=$(c_on_a_mac)
	if [ "$on_mac" = "1" ]; then
		exit
	fi
}
