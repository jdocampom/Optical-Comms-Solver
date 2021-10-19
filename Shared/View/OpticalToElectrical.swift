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
                            .onChange(of: wavelength) { _ in
                                let filtered = wavelength.filter {"0123456789.".contains($0)}
                                
                                if filtered.contains(".") {
                                    let splitted = filtered.split(separator: ".", omittingEmptySubsequences: false)
                                    if splitted.count >= 2 {
                                        let preDecimal = String(splitted[0])
                                        let afterDecimal = String(splitted[1])
                                        wavelength = "\(preDecimal).\(afterDecimal)"
                                    }
                                }
                            }
                    }
                    HStack{
                        Text("Spectral Width (nm)")
                        Spacer()
                        TextField("e.g.: 10", text: $spectralWidth, onCommit: {self.endEditing()})
                            .keyboardType(.decimalPad)
                            .frame(width: 100, height: 30, alignment: .trailing)
                            .onChange(of: spectralWidth) { _ in
                                let filtered = spectralWidth.filter {"0123456789.".contains($0)}
                                
                                if filtered.contains(".") {
                                    let splitted = filtered.split(separator: ".", omittingEmptySubsequences: false)
                                    if splitted.count >= 2 {
                                        let preDecimal = String(splitted[0])
                                        let afterDecimal = String(splitted[1])
                                        spectralWidth = "\(preDecimal).\(afterDecimal)"
                                    }
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
