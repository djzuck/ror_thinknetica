print "Введи длину стороны a: "
a = gets.chomp.to_f

print "Введи длину стороны b: "
b = gets.chomp.to_f

print "Введи длину стороны c: "
c = gets.chomp.to_f

a, b, c = [a, b, c].sort

if c**2 == a**2 + b**2
  puts "Треугольник прямоугольный."
elsif a == b && b == c
  puts "Треугольник равнобедренный и равносторонний, но не прямоугольный."
elsif a == b || b == c || c == a
  puts "Треугольник прямоугольный и равнобедренный."
else
  puts "Треугольник не прямоугольный."
end
