# Yes, I know we have a Prime class in stdlib, but I wanted to try
# implementing it myself so it gets kind of equal to Crystal 
# and Javascript implementation.

def prime?(number)
  return false if number == 0 || number == 1
  return true if number == 2

  (2..Math.sqrt(number).to_i).each do |i|
    return false if number % i == 0
  end

  true
end


prime_generator = Enumerator.new do |y|
  at = 0
  
  loop do
    y << at if prime? at
    at += 1
  end
end

primes = prime_generator.first(250_000).to_a

puts "Generated #{primes.size} primes"