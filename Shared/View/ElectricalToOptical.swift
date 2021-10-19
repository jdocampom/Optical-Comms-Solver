//
//  ElectricalToOptical.swift
//  Optical Comms Solver
//
//  Created by Juan Diego Ocampo on 10/16/21.
//

import SwiftUI
import Combine

struct ElectricalToOptical: View {
    @State var frequency: String = ""
    @State var bandwidth: String = "0"

    var id = UUID()
    var body: some View {

        let signal = ElectricalSignal(frequency: frequency, bandwidth: bandwidth)
        //        Background {
        Form {
            Section(header: Text("Electrical Domain Characteristics")) {
                HStack{
                    Text("Frequency (THz)")
                    Spacer()
                    DecimalField(placeholder: "e.g.: 250", field: $frequency)                }
                HStack{
                    Text("Bandwidth (THz)")
                    Spacer()
                    DecimalField(placeholder: "e.g.: 2", field: $bandwidth)
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
            }
            Section(header: Text("Optical Domain Characteristics")) {
                HStack {
                    Text("Wavelength (nm)")
                    Spacer()
                    Text(signal.wavelength)
                }
                HStack {
                    Text("Spectral Width (nm)")
                    Spacer()
                    Text(signal.spectralWidth)
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

struct ElectricalToOptical_Previews: PreviewProvider {
    static var previews: some View {
        ElectricalToOptical()
    }
}
