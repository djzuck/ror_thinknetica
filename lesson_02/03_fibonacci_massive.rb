fibon = [0, 1]

while (next_fibon_number = fibon[-1] + fibon[-2]) <= 100
  fibon << next_fibon_number
end

puts fibon
