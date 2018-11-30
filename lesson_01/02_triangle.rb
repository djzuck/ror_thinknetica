print "Введи длину основания: "
a = gets.chomp.to_f

print "Введи высоту треугольника: "
h = gets.chomp.to_f

s = 0.5 * (a * h)

puts "Площадь треугольника: #{ s }"
