module Enumerable
  # Your code goes here

  def my_select
    return to_enum(:my_select) unless block_given?

    filtered = []
    my_each { |element| filtered.push(element) if yield element }
    
    filtered
  end

  def my_all?
    return to_enum(:my_all?) unless block_given?

    all_true = true
    my_each { |element| all_true = false unless yield element }
    all_true
  end

  def my_any?
    return to_enum(:my_any?) unless block_given?

    any_true = false
    my_each { |element| any_true = true if yield element }
    any_true
  end

  def my_none?
    return to_enum(:my_none?) unless block_given?

    none = true
    my_each { |element| none = false if yield element }
    none
  end

  def my_count
    return self.length unless block_given?
    filtered = []
    my_each { |element| filtered.push(element) if yield element }
    filtered.length
  end

  def my_map
    transformed = []
    my_each { |element| transformed.push(yield element) }
    transformed
  end

  # inject AKA 'reduce'
  def my_inject(acc = nil)
    my_each do |element|
      acc = yield element, acc
    end
    acc
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return to_enum(:my_each) unless block_given?

    for element in self
      yield element
    end
    self
  end

  def my_each_with_index(*args)
    i = 0
    return to_enum(:my_each_with_index, *args) unless block_given?
    
    for element in self
      yield element, i
      i += 1
    end
    self
  end
end
