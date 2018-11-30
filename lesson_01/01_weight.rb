print "Hi. What's your name? "
name = gets.chomp

print "Enter your height, please: "
height = gets.chomp.to_f

weight = height - 110

if weight > 0
  puts "#{ name }, your perfect weight #{ weight }."
else
  puts "#{ name }, your weight is already perfect!"
end
