# In this challenge, your task is to write a method convert_temp that helps in
# temperature conversion. The method will receive a number as an input (temperature),
# a named parameter input_scale (scale for input temperature), and an optional parameter
# output_scale (output temperature scale, defaults to Celsius) and return the converted
# temperature. It should perform interconversion between Celsius, Fahrenheit and Kelvin scale.

def convert_temp temperature, input_scale:, output_scale: 'celsius'
  temperature = temperature.to_f
  case input_scale
  when "celsius"
    return case output_scale
    when "celsius"
      temperature
    when "fahrenheit"
      (temperature * 9 / 5) + 32
    when "kelvin"
      temperature + 273.15
    end
  when "fahrenheit"
    return case output_scale
    when "celsius"
      (temperature - 32) * 5 / 9
    when "fahrenheit"
      temperature
    when "kelvin"
      (temperature - 32) * 5 / 9 + 273.15
    end
  when "kelvin"
    return case output_scale
    when "celsius"
      temperature - 273.15
    when "fahrenheit"
      (temperature - 273.15) * 9 / 5 + 32
    when "kelvin"
      temperature
    end
  end
end

puts convert_temp(0, input_scale: 'celsius', output_scale: 'kelvin')
puts convert_temp(0, input_scale: 'celsius', output_scale: 'fahrenheit')
