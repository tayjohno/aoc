require_relative "./inputs"

puts "day01"
->(n){->(i){p i.combination(n).find{_1.sum==2020}.reduce(:*)}}.tap{|e|I1.split.map(&:to_i).tap(&e[2]).tap(&e[3])}

puts "\nday02"
puts I2.scan(/(\d+)-(\d+) (\w): (\w+)/).map{|a,b,*c|[a.to_i,b.to_i,*c]}.reduce([0]*2){|(x,y),(a,b,c,d)|[x+((a..b).cover?(d.count c)?1:0),y+((d[a-1]==c)^(d[b-1]==c)?1:0)]}

puts "\nday03"
I3.split.map(&:chars).then{|m|[1,3,5,7,1].zip([1]*4<<2).map{|x,y|(0..(m.size-1)).count{|i|(i%y==0)&&(m[i][((i*x)/y)%m[i].size]=='#')}}}.tap{p _1[1],_1.reduce(:*)}

puts "\nday04"
p %w[byr iyr eyr hgt hcl ecl pid].then{|r|I4.split("\n\n").map{_1.scan(/(\S+):(\S+)/).to_h}.tap{p _1.map(&:keys).count{|l|r&l==r}}}.count{|r|(1920..2002).cover?(r["byr"].to_i)&&(2010..2020).cover?(r["iyr"].to_i)&&(2020..2030).cover?(r["eyr"].to_i)&&((r["hgt"]=~/cm/&&(150..193).cover?(r["hgt"].to_i))||(r["hgt"]=~/in/&&(59..76).cover?(r["hgt"].to_i)))&&r["hcl"]=~/^\#[\da-f]{6}$/&&%w[amb blu brn gry grn hzl oth].include?(r["ecl"])&&r["pid"]=~/^\d{9}$/}
