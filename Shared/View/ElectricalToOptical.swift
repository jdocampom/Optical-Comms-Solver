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
                        TextField("e.g.: 250", text: $frequency, onCommit: {self.endEditing()})
                            .keyboardType(.decimalPad)
                            .frame(width: 100, height: 30, alignment: .trailing)
                            .onReceive(Just(frequency)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.frequency = filtered
                                            }
                                    }
                    }
                    HStack{
                        Text("Bandwidth (THz)")
                        Spacer()
                        TextField("e.g.: 2", text: $bandwidth, onCommit: {self.endEditing()})
                            .keyboardType(.decimalPad)
                            .frame(width: 100, height: 30, alignment: .trailing)
                            .onReceive(Just(bandwidth)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.bandwidth = filtered
                                            }
                                    }
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
