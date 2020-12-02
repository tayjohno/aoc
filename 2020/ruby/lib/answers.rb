require_relative "./inputs"

puts "day01"
s=->(c){->(a){p a.combination(c).find{_1.sum==2020}.reduce(:*)}};I1.split.map(&:to_i).tap(&s[2]).tap(&s[3])

puts "\nday02"
puts I2.scan(/(\d+)-(\d+) (\w): (\w+)/).map{|a,b,c,d|[a.to_i,b.to_i,c,d]}.reduce([0,0]){|(x,y),(a,b,c,d)|[x+((a..b).cover?(d.count c)?1:0),y+((d[a-1]==c)^(d[b-1]==c)?1:0)]}
