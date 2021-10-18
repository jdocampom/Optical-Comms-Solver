//
//  SwiftUIView.swift
//  Optical Comms Solver
//
//  Created by Juan Diego Ocampo on 10/16/21.
//

import SwiftUI
import Combine

struct OpticalToElectrical: View, Identifiable {
    
    @State var wavelength: String = ""
    @State var spectralWidth: String = "0"
    var id = UUID()
    var body: some View {
        let signal = OpticalSignal(wavelength: wavelength, spectralWidth: spectralWidth)
//        Background {
            Form {
                Section(header: Text("Optical Domain Characteristics")) {
                    HStack{
                        Text("Wavelength (nm)")
                        Spacer()
                        TextField("e.g.: 850", text: $wavelength, onCommit: {self.endEditing()})
                            .keyboardType(.decimalPad)
                            .frame(width: 100, height: 30, alignment: .trailing)
                            .onReceive(Just(wavelength)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.wavelength = filtered
                                            }
                                    }
                    }
                    HStack{
                        Text("Spectral Width (nm)")
                        Spacer()
                        TextField("e.g.: 10", text: $spectralWidth, onCommit: {self.endEditing()})
                            .keyboardType(.decimalPad)
                            .frame(width: 100, height: 30, alignment: .trailing)
                            .onReceive(Just(spectralWidth)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.spectralWidth = filtered
                                            }
                                    }
                    }
                }
                Section(header: Text("Electrical Domain Characteristics")) {
                    HStack {
                        Text("Frequency (THz)")
                        Spacer()
                        Text(signal.frequency)
                    }
                    HStack {
                        Text("Lower Frequency Limit (THz)")
                        Spacer()
                        Text(signal.lowerLimit)
                    }
                    HStack {
                        Text("Upper Frequency Limit (THz)")
                        Spacer()
                        Text(signal.upperLimit)
                    }
                    HStack {
                        Text("Bandwidth (THz)")
                        Spacer()
                        Text(signal.bandwidth)
                    }
                }
            }
            .navigationTitle(signal.title)
            .navigationBarTitleDisplayMode(.inline)
//        }
//        .onTapGesture {self.endEditing()}
    }
    
    private func endEditing() {
            UIApplication.shared.endEditing()
        }
}

struct OpticalToElectrical_Previews: PreviewProvider {
    static var previews: some View {
        OpticalToElectrical()
    }
}
