print "Введи коэффициент a: "
a = gets.chomp.to_i

print "Введи коэффициент b: "
b = gets.chomp.to_i

print "Введи коэффициент c: "
c = gets.chomp.to_i

D = b**2 - 4 * a * c

if D < 0
  puts "Корней нет."
elsif D == 0
  puts "Дискриминант: #{ D }, корень: #{ x = -b/2 * a }."
else D > 0
  m = Math.sqrt(D)
  x1 = (-b + m )/2 * a
  x2 = (-b - m )/2 * a
  puts "Дискриминант: #{ D }, корень 1: #{ x1 }, корень 2 #{ x2 }."
end
