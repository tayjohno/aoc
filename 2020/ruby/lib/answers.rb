require_relative "./inputs"

puts "day01"
->(n){->(i){p i.combination(n).find{_1.sum==2020}.reduce(:*)}}.tap{|e|I1.split.map(&:to_i).tap(&e[2]).tap(&e[3])}

puts "\nday02"
puts I2.scan(/(\d+)-(\d+) (\w): (\w+)/).map{|a,b,*c|[a.to_i,b.to_i,*c]}.reduce([0]*2){|(x,y),(a,b,c,d)|[x+((a..b).cover?(d.count c)?1:0),y+((d[a-1]==c)^(d[b-1]==c)?1:0)]}

puts "\nday03"
I3.split.map(&:chars).then{|m|[1,3,5,7,1].zip([1]*4<<2).map{|x,y|(0..(m.size-1)).count{|i|(i%y==0)&&(m[i][((i*x)/y)%m[i].size]=='#')}}}.tap{p _1[1],_1.reduce(:*)}

puts "\nday04"
I4.split("\n\n").map{_1.split.sort.join}.tap{|x|[/(([eib]yr|hgt|[he]cl|pid).+){7}/,/byr:(19[2-9]\d|200[0-2]).*ecl:(amb|blu|[bg]rn|gry|hzl|oth)eyr:20(2\d|30)hcl:\#[\da-f]{6}hgt:((59|6\d|7[0-6])in|(1[5-8]\d|19[0-3])cm)iyr:20(1\d|20)pid:\d{9}\Z/].map{|e|p x.count{_1=~e}}}

puts "\nday05"
p I5.split.map{_1.tr("FLBR","001").to_i(2)}.sort.then{((0..p(_1[-1])).to_a-_1)[-1]}
