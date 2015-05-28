require 'prime'
require './modular_arithmetic.rb'

# open class
class Array
  def sum
    reduce(:+)
  end
end

# superincreasing knapsack
class SuperKnapsack
  attr_accessor :knapsack

  def initialize(arr)
    arr.each.with_index do |k, i|
      next if i == 0
      if (k <= arr[0...i].sum)
        fail(ArgumentError, "not superincreasing at index #{i}")
      end
      @knapsack = arr
    end
  end

  def primes?(m, n)
    Prime.prime?(m) && Prime.prime?(n)
  end

  def to_general(m, n)
    arg_error = 'arguments must both be prime' unless primes?(m, n)
    arg_error = "#{n} is smaller than superincreasing knapsack" if n <= @knapsack.last
    fail(ArgumentError, arg_error) unless arg_error.nil?
    @knapsack.map { |k| (k * m) % n }
  end
end

# knapsack cipher
class KnapsackCipher
  # Default values of knapsacks, primes
  M = 41
  N = 491
  DEF_SUPER = SuperKnapsack.new([2, 3, 7, 14, 30, 57, 120, 251])
  DEF_GENERAL = DEF_SUPER.to_general(M, N)

  # Encrypts plaintext
  # Params:
  # - plaintext: String object to be encrypted
  # - generalknap: Array object containing general knapsack numbers
  # Returns:
  # - Array of encrypted numbers
  def self.encrypt(plaintext, generalknap = DEF_GENERAL)
    enc_number = lambda do |char|
      char.unpack('B*').first.chars.zip(generalknap).reduce(0) do |sum, pair|
        sum + pair.map(&:to_i).reduce(:*)
      end
    end
    plaintext.chars.map do |char|
      enc_number.call(char)
    end
  end

  # Decrypts encrypted Array
  # Params:
  # - cipherarray: Array of encrypted numbers
  # - superknap: SuperKnapsack object
  # - m: prime number
  # - n: prime number
  # Returns:
  # - String of plain text
  def self.decrypt(cipherarray, superknap = DEF_SUPER, m = M, n = N)
    unless superknap.is_a? SuperKnapsack
      fail(ArgumentError, 'Argument should be a SuperKnapsack object')
    end
  end
end
