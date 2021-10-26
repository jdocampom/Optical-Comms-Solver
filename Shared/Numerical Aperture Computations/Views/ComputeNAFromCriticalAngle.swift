//
//  ComputeNAFromCriticalAngle.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/25/21.
//

import SwiftUI

struct ComputeNAFromCriticalAngle: View {
    
    @State var coreRefractiveIndex: String = ""
    @State var criticalAngle: String = ""
    
    var body: some View {
        let data = NumericalApertureCalculation()
        return Form {
            Section(header: Text("Parameters")) {
                HStack{
                    Text("Refractive Index (Core)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 1.2", field: $coreRefractiveIndex)
                }
                HStack {
                    Text("Critical Angle (Deg)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 20", field: $criticalAngle)
                }
            }
            Section(header: Text("Results")) {
                HStack {
                    Text("Numerical Aperture").customStyle()
                    Spacer()
                    Text(data.compute(from: .criticalAngle, n1: coreRefractiveIndex, thetaC: criticalAngle))
                }
            }
            .navigationTitle("Numerical Aperture")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ComputeNAFromCriticalAngle_Previews: PreviewProvider {
    static var previews: some View {
        ComputeNAFromCriticalAngle()
    }
}
