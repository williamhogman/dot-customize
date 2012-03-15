
#
# OS Compatiblity functions
#


function c_on_a_mac(){
	OS = $(uname)
	if [ $OS="Darwin" ]; then
		return 1
	fi
	return 0
}

function c_dont_run_on_mac() {
	if [c_on_a_mac];
}
