require_relative "./inputs"
require "csv"

puts "day01" # 113 characters
->(n){->(i){p i.combination(n).find{_1.sum==2020}.reduce(:*)}}.tap{|e|I1.split.map(&:to_i).tap(&e[2]).tap(&e[3])}

puts "\nday02" # 170 characters
puts I2.scan(/(\d+)-(\d+) (\w): (\w+)/).map{|a,b,*c|[a.to_i,b.to_i,*c]}.reduce([0]*2){|(x,y),(a,b,c,d)|[x+((a..b).cover?(d.count c)?1:0),y+((d[a-1]==c)^(d[b-1]==c)?1:0)]}

puts "\nday03" # 162 characters
I3.split.map(&:chars).then{|m|[1,3,5,7,1].zip([1]*4<<2).map{|x,y|(0..(m.size-1)).count{|i|(i%y==0)&&(m[i][((i*x)/y)%m[i].size]=='#')}}}.tap{p _1[1],_1.reduce(:*)}

puts "\nday04" # 269 characters
I4.split("\n\n").map{_1.split.sort.join}.tap{|x|[/(([eib]yr|hgt|[he]cl|pid).+){7}/,/byr:(19[2-9]\d|200[0-2]).*ecl:(amb|blu|[bg]rn|gry|hzl|oth)eyr:20(2\d|30)hcl:\#[\da-f]{6}hgt:((59|6\d|7[0-6])in|(1[5-8]\d|19[0-3])cm)iyr:20(1\d|20)pid:\d{9}\Z/].map{|e|p x.count{_1=~e}}}

puts "\nday05" # 83 characters
p I5.split.map{_1.tr("FLBR","001").to_i(2)}.sort.then{((0..p(_1[-1])).to_a-_1)[-1]}

puts "\nday06" # 131 characters
I6.split("\n\n").map{_1.split("\n").map(&:chars)}.tap{|i|p i.map{_1.flatten.uniq.size}.sum}.tap{|i|p i.map{_1.reduce(:&).size}.sum}

puts "\nday07"

puts "\nday08" # 504 characters
[I8.split("\n").map{|l|l.match(/(\w+) (.\d+)/)[1..2].then{|a,b|[a,b.to_i]}},{"acc"=>->(v,s){s[:a]+=v;s[:l]+=1},"jmp"=>->(v,s){s[:l]+=v},"nop"=>->(_v,s){s[:l]+=1}},->{{a:0,l:0,h:{}}}].tap{|n,c,l|l[].tap{|s|until(s[:h][s[:l]]&&p(s[:a]))do((s[:h][s[:l]]=1)&&c[n[s[:l]][0]][n[s[:l]][1],s])end}}.tap{|n,c,l|(0..(n.size-1)).each{|i|l[].tap{|s|n.map(&:clone).tap{|n|n[i][0]=n[i][0].tr("jmno","nojm")}.tap{|n| until(s[:l]==n.size&&p(s[:a]))||s[:h][s[:l]]do((s[:h][s[:l]]=1)&&c[n[s[:l]][0]][n[s[:l]][1],s])end}}}}

puts "\nday09" # 301 characters
p I9.split("\n").map(&:to_i).then{[_1[0..24],_1[25..-1]]}.then{|h,l|[h+l,h.dup.then{|c|->{l.each{|i|return p(i)unless c.combination(2).any?{_1.sum==i}&&(c.tap{_1.delete_at(0)}<<i)}}[]}]}.then{|h,v|h.then{|n|(0..(n.size)).to_a.combination(2).find{n[_1.._2].sum==v}.then{n[_1.._2]}.then{_1.min+_1.max}}}

puts "\nday10" # 216 characters
p I10.split.map(&:to_i).sort.tap{|v|p (0..v.size-2).reduce({1=>1,3=>1}){|o,i|o.tap{_1[v[i+1]-v[i]]+=1}}.values.reduce(:*)}.then{|v|->(){c=->(i,m){m[i]||=(i+1..i+3).map{v.include?(_1)?c[_1,m]:0}.sum}}[][0,{v.max=>1}]}

puts "\nday11" # 482 characters ONLY PART TWO
# p I11.split.map(&:chars).then{|o|[o,o.dup.map(&:dup),o.size-1,o.first.size-1]}.tap{|o,c,j,k|->(x,y,m){[*-1..1].repeated_permutation(2).reject{_1|_2==0}.map{|d,e|(s=->(x,y,d,e,m){(x<0||y<0||x>j||y>k)?nil :(m[x][y]!=".")?m[x][y]:s[x+d,y+e,d,e,m]})[x+d,y+e,d,e,m]}}.tap{|a|loop{(0..j).each{|x|(0..k).each{|y|c[x][y]=o[x][y]=="L"&&!a[x,y,o].any?{|c|c=="#"}?"#":o[x][y]=="#"&&a[x,y,o].count{|c|c=="#"}>=5?"L":c[x][y]}}&&(break if c==o)||(o=c.dup.map(&:dup))}}}[1].flatten.count{_1=="#"}

puts "\nday12"

puts "\nday13" # 282 characters
I13.split.then{[_1[0].to_i,_1[1].split(",").map(&:to_i).map.with_index.reject{|i|i[0]<1}]}.tap{|t,z|p z.map{|b,_|[b-(t%b)+t,b]}.min.then{(_1-t)*_2}}.then{|_,z|p ([z[0][0]]*2).tap{|s| z[1..-1].each {|b,t|(1..).lazy.map{s[0]+(_1*s[1])}.find{|i|(i+t)%b==0 and s[0]=i and s[1]*=b}}}[0]}
