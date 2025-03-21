function mkcdir
	mkdir -p -- $argv
	set oldstat $status
	if test $oldstat -ne 0
		return $oldstat
	end
	cd -- $argv
end
