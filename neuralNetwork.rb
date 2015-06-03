#!/usr/bin/ruby

require "rubygems" # Depended on by "ai4r"
require "ai4r"     # NeuralNetwork stuff
require "yaml"     # Storing networks in files

# Globals
LambdaNet = Ai4r::NeuralNetwork::Backpropagation.new [0]

def netFileName netName
    return "./saves/#{netName.downcase}.ai4r.yaml"
end

def correctNetLambdas net
    net.initial_weight_function = LambdaNet.initial_weight_function
    net.propagation_function = LambdaNet.propagation_function
    net.derivative_propagation_function = LambdaNet.derivative_propagation_function
end

def getNet netName, inputL, outputL
    filename = netFileName netName
    if File.exist? filename
        net = YAML.load(File.read(filename))
        correctNetLambdas net
        return net
    else
        return Ai4r::NeuralNetwork::Backpropagation.new [inputL, inputL * outputL, outputL]
    end
end

def saveNets netMap
    for netSet in netMap
        net = netSet[1]
        net.initial_weight_function = nil
        net.propagation_function = nil
        net.derivative_propagation_function = nil
        File.write(netFileName(netSet[0]), YAML.dump(net))
        correctNetLambdas net
    end
end

netMap = {
   "AND" => nil,
   "OR"  => nil,
   "XOR" => nil,
   "NOT" => nil,
   "LS"  => nil,
   "RS"  => nil,
}

for net in netMap
    netName = net[0]
    netMap[netName] = getNet netName, 8, 8
end

puts "Entering interactive mode. Type HELP for assistance."
while true
    print "$> "
    input = gets.chomp.upcase
    if ["H", "HELP"].include? input
        puts "H | HELP"
        puts "    This help message"
        puts "Q | QUIT | EXIT"
        puts "    Exits the program safely."
    elsif ["Q", "QUIT", "EXIT"].include? input
        break
    elsif input.strip.empty?
        # String is empty. Do nothing.
    else
        puts "ERROR: \"#{input}\" is not understood."
    end
end

saveNets netMap

