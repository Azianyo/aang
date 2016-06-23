class ObjectNeuron

  attr_accessor :receptors, :number, :excitation, :class_name

  ACTIVATION_THRESHOLD = 5

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
    @excitation = @receptors.map(&:excitation).inject(0, &:+).round(2)
  end

  def calc_activation_time
    @activation_time = 1/@excitation
  end
end
