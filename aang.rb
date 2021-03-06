require 'pry'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

# initialize temporary variables
traits = ["sepal length","sepal width", "petal length", "petal width", "class"]

sensory_fields = traits.map{ |trait| SensoryField.new(trait) }
neurons = []

File.foreach("#{File.dirname(__FILE__)}/iris.txt").with_index do |line, line_num|

  attributes = line.split(",")
  object_neuron = ObjectNeuron.new(line_num+1, attributes.last)
  neurons << object_neuron
  attributes.last.strip!

  attributes.each_with_index do |elem, i|
    receptor = ReceptorNeuron.new(elem, traits[i])
    #add receptor to sensory field
    sensory_fields[i].add_receptor_and_sort(receptor)
    #link neuron and receptor
    object_neuron.receptors << receptor
    receptor.obj_neurons << object_neuron
  end
end

puts "Do you want to excite receptor or object neuron (R/N)?"
choice = gets.chomp

input_values = []

case choice
when "R"
  traits.each_with_index do |t,i|
    field = sensory_fields[i]
    puts "Please specify #{t} value:"
    input_values << gets.chomp
    if t != "class"
      input_values[i] = input_values[i].to_f
      field.calculate_excitations(input_values[i])
    else
      input_values[i] = input_values[i]
      field.calculate_excitations_for_strings(input_values[i])
    end
  end
  neurons.each(&:calc_activation_time)
when "N"
  puts "Specify neuron number:"
  neuron_number = gets.chomp.to_f

  while neuron_number < 1 || neuron_number > neurons.count
    puts "Neuron not found, specify number between 1 and #{neurons.count}!"
    neuron_number = gets.chomp.to_f
  end

  neurons[neuron_number].excite_receptors

  puts "Excitations of neurons:"

  neurons.each do |n|
    puts "Neuron number #{n.number}: #{n.excitation}"
  end

else
  puts "Please type either R or N!"
end

puts "Excitations of neurons for input values: #{input_values}"

neurons.each do |n|
  puts "Neuron number #{n.number}: excitation - #{n.excitation}, activation time - #{n.activation_time.round(2)} "
end

puts "If you want to:"
puts "try again - press A"
puts "sort neurons according to their excitation value - S"
puts "get further sensory fields info - press M"
puts "exit program - press Q"
choice = gets.chomp

case choice
when "A"
when "S"
  neurons.sort_by!{ |n| n.excitation }
  neurons.reverse!
  puts "Neurons sorted by excitation for input values: #{input_values}"
  neurons.each do |n|
    puts "Neuron number #{n.number}: #{n.excitation}"
  end
when "M"
  #print additional sensory field info
  sensory_fields.each do |f|
    unless f.attribute_name == "class"
      puts "Field " + f.attribute_name
      puts "max value: #{f.max_neuron.represented_value}"
      puts "min value: #{f.min_neuron.represented_value}"
      puts "interval width: #{f.interval}"
      puts "==========="
    end
  end
when "Q"
  #exit program
  puts "KTHXBAI!"
  exit
end
