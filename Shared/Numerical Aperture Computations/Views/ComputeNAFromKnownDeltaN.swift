//
//  ComputeNAFromKnownDeltaN.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/25/21.
//

import SwiftUI

struct ComputeNAFromKnownDeltaN: View {

    @State var coreRefractiveIndex: String = ""
    @State var refractiveIndexDelta: String = ""
    
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
                    Text("Refractive Index Delta (%)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 0.03", field: $refractiveIndexDelta)
                }
            }
            Section(header: Text("Results")) {
                HStack {
                    Text("Numerical Aperture").customStyle()
                    Spacer()
                    Text(data.compute(from: .knownDeltaN, n1: coreRefractiveIndex, delta: refractiveIndexDelta))
                }
            }
            .navigationTitle("Numerical Aperture")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ComputeNAFromKnownDeltaN_Previews: PreviewProvider {
    static var previews: some View {
        ComputeNAFromKnownDeltaN()
    }
}
