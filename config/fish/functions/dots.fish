set FISH_DIR (dirname (dirname (status --current-filename)))
if command -v git &>/dev/null
	if git -C $FISH_DIR rev-parse &>/dev/null
		set DOTS $(git -C $FISH_DIR rev-parse --show-toplevel)
		function dots
			git -C $DOTS $argv
		end
	else
		function dots
			echo "No repository was found"
		end
	end
else
	function dots
		echo "Cannot execute git"
	end
end
