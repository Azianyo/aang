class SensoryField

  attr_accessor :receptors, :attribute_name, :max_neuron, :min_neuron, :interval

  def initialize attribute_name
    @receptors = []
    @attribute_name = attribute_name
  end

  def add_receptor_and_sort receptor
    @receptors << receptor
    @receptors.sort_by!{ |r| r.represented_value }
  end

  def calculate_interval
    @max_neuron = @receptors.last
    @min_neuron = @receptors.first
    @interval = @max_neuron.represented_value - @min_neuron.represented_value
  end

  def calculate_excitations input_val
    @receptors.each{|r| r.calc_excitation(input_val, calculate_interval)}
  end

  def calculate_excitations_for_strings input_string
    @receptors.each{|r| r.calc_excitation_for_strings(input_string)}
  end
end
