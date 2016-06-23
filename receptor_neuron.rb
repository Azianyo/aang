class ReceptorNeuron

  attr_accessor :represented_value, :trait_name, :obj_neurons, :excitation

  ACTIVATION_THRESHOLD = 1

  def initialize represented_value, trait_name
    if represented_value =~ /\d/
      @represented_value =  represented_value.gsub(/[^\d^\.]/, '').to_f
    else
      @represented_value =  represented_value
    end
    @trait_name = trait_name
    @obj_neurons = []
    @excitation = 0
  end

  def add_object_neuron neuron
    @obj_neurons << neuron
  end

  def calc_excitation input_val, field_width
    @excitation = 1 - (@represented_value - input_val).abs/field_width
    excite_neurons
  end

  def activated?
    @excitation >= ACTIVATION_THRESHOLD
  end

  def excite_neurons
    if activated?
      @obj_neurons.each(&:excite)
    end
  end

  def calc_excitation_for_strings string_input
    if string_input == @represented_value
      @excitation = @excitation + 1
      excite_neurons
    end
  end

  # def calc_activation_time field_width, input_val
  #   @activation_time = field_width/(field_width - abs())
  # end
end
