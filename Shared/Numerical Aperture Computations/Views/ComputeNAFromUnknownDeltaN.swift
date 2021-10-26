//
//  ComputeNAFromUnknownDeltaN.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/25/21.
//

import SwiftUI

struct ComputeNAFromUnknownDeltaN: View {
    
    @State var coreRefractiveIndex: String = ""
    @State var claddingRefractiveIndex: String = ""
    
    var body: some View {
        let data = NumericalApertureCalculation()
        return Form {
            Section(header: Text("Parameters")) {
                HStack{
                    Text("Refractive Index (Core)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 1.6", field: $coreRefractiveIndex)
                }
                HStack {
                    Text("Refractive Index (Cladding)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 1.4", field: $claddingRefractiveIndex)
                }
            }
            Section(header: Text("Results")) {
                HStack {
                    Text("Numerical Aperture").customStyle()
                    Spacer()
                    Text(data.compute(from: .unknownDeltaN, n1: coreRefractiveIndex, n2: claddingRefractiveIndex))
                }
            }
            .navigationTitle("Numerical Aperture")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ComputeNAFromUnknownDeltaN_Previews: PreviewProvider {
    static var previews: some View {
        ComputeNAFromUnknownDeltaN()
    }
}
