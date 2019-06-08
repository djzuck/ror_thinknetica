months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
leap = "не високосный"

print "Введи год: "
year = gets.to_i

if year % 400 == 0 || year % 4 == 0 && year % 100 != 0
  months[1] = 29
  leap = "високосный"
end

print "Введи день: "
day = gets.to_i
print "Введи номер месяца: "
month = gets.to_i

if month > 12 || month < 1
  puts "Ты ввел неверный номер месяца."
  exit
end

if day > months[month - 1] || day <= 0
  puts "Ты ввел неверный день месяца."
  exit
end

date_number = day

date_number += months.take(month - 1).sum

puts "Порядковый номер даты: #{date_number}. (Год #{leap})"
