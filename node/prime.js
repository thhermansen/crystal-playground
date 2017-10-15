function isPrime(number) {
  if (number == 0 || number == 1) return false
  if (number == 2) return true
  
  const to = Math.sqrt(number)
  
  for (let i = 2; i <= to; i++) {
    if (number % i == 0) return false
  }
  
  return true
}

function *primesGenerator() {
  let at = 0
  
  while(true) {
    if (isPrime(at)) {
      yield at
    }
    
    at++
  }
}

const first = 500000
const generator = primesGenerator()
const primes = []

for (let prime of generator) {
  primes.push(prime)
  if (primes.length >= first) break
}



console.log(`Generated ${primes.length} primes`)