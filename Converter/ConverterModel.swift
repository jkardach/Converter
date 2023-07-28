//
//  ConverterModel.swift
//  Converter
//
//  Created by jim kardach on 7/27/23.
//
/*
 This struct is for pickers who wish to do converters
 
 The "converters" Array gives the name of the converter you wish to use
 
 Pass the name of the converter (from converters array) to
    func converterType(converterType: String) -> Array
 
 and this will return an array of conversion types for that type of converter.
 
 The values of this array will give the convertTo and convertFrom values you
 pick so you can do a conversion.
 
 set the convertTo and convertFrom values using the respective functions:
 
    func convertTo(to: String)
    func convertFrom(from: String)
 
 Then to convert use the following function:
    func convert(input: Double) -> Double
 */

import Foundation

class ConverterModel: ObservableObject {
    let converters = ["temperature", "length", "time", "volume"]
    
    let converterArray = [
        "temperature": ["Celsius", "Fahrenheit", "Kelvin"],
        "length": ["meters", "kilometers", "feet", "yards", "miles"],
        "time": ["seconds", "minutes", "hours", "days"],
        "volume": ["milliliters", "liters", "cups", "pints", "gallons"]
        ]
    
    @Published var convertType: String = "temperature" {
        didSet {
            self.convertArray = converterArray[convertType]!
            self.convertFrom = convertArray[0]
            self.convertTo = convertArray[1]
            //objectWillChange.send()
        }
    }
    
    var convertArray: [String]
    
    @Published var convertFrom = "Celsius"
    @Published var convertTo = "Fahrenheit"
    
    init(convert: String) {
        self.convertType = convert
        self.convertArray = converterArray[convert]!
        self.convertFrom = convertArray[0]
        self.convertTo = convertArray[1]
    }
    
    // This returns an array of what can be converted
    func converterType(convert: String) {
        self.convertType = convert
        self.convertArray = converterArray[convert]!
        self.convertFrom = convertArray[0]
        self.convertTo = convertArray[1]
    }
    
    func convert(value: String) -> String {
        let input = Double(value) ?? 0.0
        let formatter = MeasurementFormatter()
        if convertType == "temperature" {
            var tempTo: Measurement<UnitTemperature>
            
            if convertFrom == "Celsius" {
                tempTo = Measurement(value: input, unit: UnitTemperature.celsius)
            } else if convertFrom == "Fahrenheit" {
                tempTo = Measurement(value: input, unit: UnitTemperature.fahrenheit)
            } else {    // Kelvin
                tempTo = Measurement(value: input, unit: UnitTemperature.kelvin)
            }
            if convertTo == "Celsius" {
                tempTo.convert(to: UnitTemperature.celsius)
            } else if convertTo == "Fahrenheit" {
                tempTo.convert(to: UnitTemperature.fahrenheit)
            } else if convertTo == "Kelvin" {
                tempTo.convert(to: UnitTemperature.kelvin)
            }
            formatter.unitOptions = .providedUnit
            return formatter.string(from: tempTo)
            
            // length conversions: ["meters", "kilometers", "feet", "yards", "miles"]
        } else if convertType == "length" {
            var tempTo: Measurement<UnitLength>
            
            if convertFrom == "meters" {
                tempTo = Measurement(value: input, unit: UnitLength.meters)
            } else if convertFrom == "kilometers" {
                tempTo = Measurement(value: input, unit: UnitLength.kilometers)
            } else if convertFrom == "feet" {
                tempTo = Measurement(value: input, unit: UnitLength.feet)
            } else if convertFrom == "yards" {
                tempTo = Measurement(value: input, unit: UnitLength.yards)
            } else {    // miles
                tempTo = Measurement(value: input, unit: UnitLength.miles)
            }
            if convertTo == "meters" {
                tempTo.convert(to: UnitLength.meters)
            } else if convertTo == "kilometers" {
                tempTo.convert(to: UnitLength.kilometers)
            } else if convertTo == "feet" {
                tempTo.convert(to: UnitLength.feet)
            } else if convertTo == "yards" {
                tempTo.convert(to: UnitLength.yards)
            } else if convertTo == "miles" {
                tempTo.convert(to: UnitLength.miles)
            }
            formatter.unitOptions = .providedUnit
            return formatter.string(from: tempTo)

            // ["seconds", "minutes", "hours", "days"]
        } else if convertType == "time" { // d->s, d->m, d->h
            var tempTo: Measurement<UnitDuration>
            if convertFrom == "seconds" {
                tempTo = Measurement(value: input, unit: UnitDuration.seconds)
            } else if convertFrom == "minutes" {
                tempTo = Measurement(value: input, unit: UnitDuration.minutes)
            } else if convertFrom == "hours" {
                tempTo = Measurement(value: input, unit: UnitDuration.hours)
            } else { // days
                tempTo = Measurement(value: input, unit: UnitDuration.days)
            }

            if convertTo == "seconds" {
                tempTo.convert(to: UnitDuration.seconds)
            } else if convertTo == "minutes" {
                tempTo.convert(to: UnitDuration.minutes)
            } else if convertTo == "hours" {
                tempTo.convert(to: UnitDuration.hours)
            } else if convertTo == "days" {
                tempTo.convert(to: UnitDuration.days)
            }
            formatter.unitOptions = .providedUnit
            return formatter.string(from: tempTo)
        } else {    // Volume ["milliliters", "liters", "cups", "pints", "gallons"]
            var tempTo: Measurement<UnitVolume>
            if convertFrom == "milliliters" {
                tempTo = Measurement(value: input, unit: UnitVolume.milliliters)
            } else if convertFrom == "liters" {
                tempTo = Measurement(value: input, unit: UnitVolume.liters)
            } else if convertFrom == "cups" {
                tempTo = Measurement(value: input, unit: UnitVolume.cups)
            } else {    // pints
                tempTo = Measurement(value: input, unit: UnitVolume.pints)
            }
            if convertTo == "milliliters" {
                tempTo.convert(to: UnitVolume.milliliters)
            } else if convertTo == "liters" {
                tempTo.convert(to: UnitVolume.liters)
            } else if convertTo == "cups" {
                tempTo.convert(to: UnitVolume.cups)
            } else if convertTo == "pints" {
                tempTo.convert(to: UnitVolume.pints)
            }
            formatter.unitOptions = .providedUnit
            return formatter.string(from: tempTo)
        }
    }
}

extension UnitDuration {
    static let days = UnitDuration(symbol: "day", converter: UnitConverterLinear(coefficient: 86400.0))
}
