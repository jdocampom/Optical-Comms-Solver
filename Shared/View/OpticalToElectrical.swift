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
                        DecimalField(placeholder: "e.g.: 1550", field: $wavelength)
                    }
                    HStack{
                        Text("Spectral Width (nm)")
                        Spacer()
                        DecimalField(placeholder: "e.g.: 10", field: $spectralWidth)
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
