#! /usr/bin/ruby -w

$help_info = <<HELP

                    KanaHelper
====================================================
= This is a tiny Ruby program that aims at helping =
= myself remember japanese 50 kanas.               =
= (see http://en.wikipedia.org/wiki/Goj%C5%ABon)   =
====================================================  

HELP

# class definition of a kana
class Kana
	attr_reader :hiragana, :katakana, :romaji
	
	def initialize(a)
		@hiragana = a[0]
		@katakana = a[1]
		@romaji   = a[2]
	end

	def to_s
		"#{@romaji}\t#{@hiragana}\t#{@katakana}\n"
	end
end

class KanaTable
	attr_reader :Kanas
	
	def initialize()
		@Kanas = Array.new(10){Array.new(5)} 
		# read in the kana.txt
		# build the 50 Gojun table
		x = y = 0
		fp = File.open("kana.txt","r")	
		fp.each{|line| 
			arr  = line.chomp.split("\t")
			kana = Kana.new(arr)
			@Kanas[x][y] = kana
			y == 4 ? (x += 1; y = 0):(y += 1)
		}
		fp.close
	end
	
	def	pos(i,j)
		@Kanas[i][j]
	end

	# four show methods
	# para:
	# 	s: from which line to START
	# 	e: to whichi line to end
	def show(s = 1,e = 10)
		for i in s..e
			for j in 0..4
				 print "#{@Kanas[i-1][j].hiragana}#{@Kanas[i-1][j].katakana}\t"
				 print "\n" if j == 4
			end
		end
	end

	def show_hiragana(s = 1,e = 10)
		for i in s..e
			for j in 0..4
				 print "#{@Kanas[i-1][j].hiragana}\t"
				 print "\n" if j == 4
			end
		end
	end

	def show_katakana(s = 1,e = 10)
		for i in s..e
			for j in 0..4
				 print "#{@Kanas[i-1][j].katakana}\t"
				 print "\n" if j == 4
			end
		end
	end

	def show_romaji(s = 1,e=10)
		for i in s..e
			for j in 0..4
				 print "#{@Kanas[i-1][j].romaji}\t"
				 print "\n" if j == 4
			end
		end
	end

end

# the core class
class Core
	attr_reader :kt

	def initialize
		@kt = KanaTable.new
	end
	
	def start
		puts "From which line?"
		from = gets.chomp.to_i
		puts "To which line?"
		to = gets.chomp.to_i
		puts "-" * 20
		@kt.show(from,to)
		puts "-" * 20
		puts "Please enter the romaji of the showing kana: "
		
		while(1)
			x = (from + (to - from)*rand).round - 1
			y = rand(5)
			rand > 0.5 ? (puts @kt.pos(x,y).hiragana):(puts @kt.pos(x,y).katakana)

			ans = gets.chomp
			break if ans == 'exit'
			if ans == 'help' then 
				help
				next
			end
			ans == @kt.pos(x,y).romaji ? (puts "Correct!"):(puts "Sorry! It's #{@kt.pos(x,y).romaji}")
		end
	end

	def help
		puts $help_info
	end
end

# run
Core.new.start
