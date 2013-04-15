# test translation from unicode to Kana

for k in 12354..12400
	print k.chr('UTF-8')
	print (k+96).chr('UTF-8')
	print "\n"
end
