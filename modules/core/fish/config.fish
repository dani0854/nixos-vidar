if status is-interactive
	function fish_prompt
	    eval powerline-go -error $status -jobs (count (jobs -p))
	end
end
