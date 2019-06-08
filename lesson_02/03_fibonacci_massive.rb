fibon = [0, 1]

loop do
  next_fibon_number = fibon[-1] + fibon[-2]
  break if next_fibon_number > 100
  fibon << next_fibon_number
end

puts fibon
