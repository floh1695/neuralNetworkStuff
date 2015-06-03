#!/usr/bin/ruby

require "rubygems" # Depended on by "ai4r"
require "ai4r"     # NeuralNetwork stuff
require "yaml"     # Storing networks in files

def netFileName netName
    return "./saves/#{netName.downcase}.ai4r.yaml"
end

def getNet netName, inputL, outputL
    filename = netFileName 
    #return Ai4r::NeuralNetwork::Backpropagation.new [inputL, inputL * outputL, outputL]
end

def saveNets netMap
    for netSet in netMap
        File.write(netFileName(netSet[0]), YAML.dump(netSet[1]))
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

puts "Entering interactive mode"
while true
    # TODO: Interactive stuff here
    input = gets.chomp.upcase
    if ["QUIT", "EXIT"].include? input
        break
    end
end

saveNets netMap

