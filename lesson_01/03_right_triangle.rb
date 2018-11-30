my_triangle=[]
print "Введи длину стороны a: "
my_triangle<<gets.chomp.to_i

print "Введи длину стороны b: "
my_triangle<<gets.chomp.to_i

print "Введи длину стороны c: "
my_triangle<<gets.chomp.to_i

a, b, c = my_triangle.sort.reverse

if c**2==a**2+b**2
  puts "Треугольник прямоугольный."
elsif a==b&&b==c
  puts "Треугольник равнобедренный и равносторонний, но не прямоугольный."
elsif a==b||b==c||c==a
  puts "Треугольник прямоугольный и равнобедренный."
else
  puts "Треугольник не прямоугольный."
end
