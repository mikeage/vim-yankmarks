function! Yankmark()
	let save_cursor = getpos(".")
	let n = 0
	" I should really make this a parameter...
	let marks_to_yank="abcdefghijklmnopqrstuvwxyz"
	let nummarks = strlen(marks_to_yank)
	" Clear the a register
	let @a=''
	while n < nummarks
		let c = strpart(marks_to_yank, n, 1)
		" Is the mark defined
		if  getpos("'".c)[2] != 0
			" using g' instead of ' doesn't mess with the jumplist
			exec "normal g'".c
			normal "Ayy
		endif
		let n = n + 1
	endwhile
	call setpos('.', save_cursor)
endfunction
