set number
set numberwidth=1
set norelativenumber
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

