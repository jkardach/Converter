//
//  ContentView.swift
//  Converter
//
//  Created by jim kardach on 7/27/23.
//

import SwiftUI


struct ContentView: View {
    @StateObject var converter = ConverterModel(convert: "temperature")

    @State private var inputValue: String = "1"
    @State private var outputValue: String = ""

    var body: some View {
    
        Form {
            Section(header:Text("Converter")) {
                Picker("Type of Conversion", selection: $converter.convertType) {
                    ForEach(converter.converters, id: \.self) {
                        Text($0)
                    }
                }
            }
            Section(header: Text("\(converter.convertType) Conversion")) {
                Picker("From", selection: $converter.convertFrom) {
                    ForEach(converter.convertArray, id: \.self) {
                        Text($0)
                    }
                }
                Picker("To", selection: $converter.convertTo) {
                    ForEach(converter.convertArray, id: \.self) {
                        Text($0)
                    }
                }
            }
            Section(header: Text("Enter A Value")) {
                TextField("Enter a Value", text: $inputValue)
                Text(converter.convert(value: inputValue))
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
