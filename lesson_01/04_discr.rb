print "Введи коэффициент a: "
a = gets.chomp.to_i

print "Введи коэффициент b: "
b = gets.chomp.to_i

print "Введи коэффициент c: "
c = gets.chomp.to_i

d = b**2 - 4 * a * c

if d < 0
  puts "Корней нет."
elsif d == 0
  puts "Дискриминант: #{ d }, корень: #{ x = -b/2 * a }."
else d > 0
  m = Math.sqrt(d)
  x1 = (-b + m) / 2 * a
  x2 = (-b - m) / 2 * a
  puts "Дискриминант: #{ d }, корень 1: #{ x1 }, корень 2 #{ x2 }."
end
