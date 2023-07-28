# Converter

My 100 Days of SwiftUI Day 19 project.  This is a converter that converts from one set of units to another for temperature, length, time and volume. This application has three pickers.

  1. The first is used to pick the type of conversion (temperature, length, time or volume).
  2. The second is used to pick the from units
  3. The third is used to pick the to units

A textfield is used to input the number to convert (initialized to 1), and a textview is used for the output.

Most of the work is done in the ConverterModel class. This model provides an array of dictionaries where each dictionary is a conversion topic that points to the conversion units. and a second array which contains the dictionary keys (temperature, length, time, volume to help pick the right dictionary).

For the UI the model has three published varaibles:
  convertType - which picks which dictionary to pick (which converter I want to use)
  convertFrom - picks the starting unit
  convertTo - picks the final unit

The intializer sets the convertType, convertArray, and picks the initial convertFrom and convertTo (used index 0 and 1 of the selected array from the dictionary).

The convertType contains a didSet so the other variables can be modified when convertType is updated by the UI (updates the convertArray, the convertFrom and convertTo variables).

The conversion is done via a method convert(value: String)-> String.  

It converts the string to a double, creates a formatter, and then checks if its converting a temperature, length, time or volume.  It them creates a object holder, tempTo, of the appropriate type (Measurement<UnitTemperature>, Measurement<UnitLength>, Measurement<UnitDuration>, Measurement<UnitVolume>.

I then check the convertFrom and then fill in the appropriate object to the tempTo holder.  For example if converting from fahrenheit:
   tempTo  Measurement(value: input, unit: UnitTemperature.fahrenheit)

One complication was the UnitDuration did not support a day duration.  This caused me to extend Unit duration: 

extension UnitDuration {
    static let days = UnitDuration(symbol: "day", converter: UnitConverterLinear(coefficient: 86400.0))
}

Now it supports day :)

Continuing I would then check the convertTo, and then I can convert the value to the appropriate units (in this case Kelvin) via:
   tempTo.convert(to: UnitTemperature.kelvin)

I then format the output into a string via:

formatter.unitOptions = .providedUnit
formatter.string(from: tempTo)

![image](https://github.com/jkardach/Converter/assets/3701488/d6597694-ecba-4649-99e7-4f8eb0b3d9a3)

