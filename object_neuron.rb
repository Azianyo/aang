class ObjectNeuron

  attr_accessor :receptors, :number, :excitation, :class_name

  ACTIVATION_THRESHOLD = 4

  def initialize number, class_name
    @receptors = []
    @number = number
    @class_name = class_name
    @excitation = 0
  end

  def activated?
    @excitation >= ACTIVATION_THRESHOLD
  end

  def excite
    @excitation = @excitation + 1
  end
end
