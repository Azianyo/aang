module FileReader
  def read_file file_path, sensory_fields

    File.foreach(file_path).with_index do |line, line_num|

      attributes = line.split(",")
      object_neuron = ObjectNeuron.new(line_num, attributes.last)
      neurons << object_neuron

      attributes.each_with_index do |elem, i|
        receptor = ReceptorNeuron.new(elem, i)
        #add receptor to sensory field
        sensory_fields[i].add_receptor_and_sort(receptor)
        #link neuron and receptor
        object_neuron.receptors << receptor
        receptor.obj_neurons << object_neuron
      end
    end
  end
end
