#!/bin/zsh
foo='abcdefghij'
for (( i = 1; i <= 10; i++ )); do
	goo=${foo[1,$i]}
	print ${(l:10)goo} ${(r:10)goo}
done
