# test translation from unicode to Kana

for k in 12353..12400
	next if k%2 == 0
	
	hiragana = k.chr('UTF-8')
	katakana = (k+96).chr('UTF-8')
	unknown_h  = (k+1).chr('UTF-8')
	unknown_k  = (k+97).chr('UTF-8')
	
	print "#{hiragana} - #{katakana} - #{unknown_h} - #{unknown_k}\n"
end


gets	# to pause in Windows