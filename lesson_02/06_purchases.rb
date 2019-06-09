basket = {}
cost = 0
sum_purchases = 0

loop do
  print "Введи название товара или Стоп для оплаты покупок: "
  name = gets.chomp
  break if name.downcase == 'стоп'

  print 'Введи цену товара: '
  price = gets.to_f
  print 'Сколько взято единиц товара: '
  quantity = gets.to_f

  basket[name] = { price: price, quantity: quantity }
end

puts "| Название товара | Цена за единицу | Количество единиц | Итоговая стоимость |"
puts "| --------------------------------------------------------------------------- |"

basket.each do |key, value|
  cost = value[:price] * value[:quantity]
  puts "#{key} | #{value[:price]} | #{value[:quantity]} | #{cost}"
  sum_purchases += cost
end

puts "| --------------------------------------------------------------------------- |"
puts "Итого к оплате: #{sum_purchases} руб."
