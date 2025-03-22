if command -v git &>/dev/null && git -C (pwd) rev-parse
	set DOTS $(git -C (pwd) rev-parse --show-toplevel)
	function dots
		git -C $DOTS $argv
	end
end
