//
//  ComputeNAFromAcceptanceAngle.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/25/21.
//

import SwiftUI

struct ComputeNAFromAcceptanceAngle: View {
    
    @State var mediumRefractiveIndex: String = ""
    @State var acceptanceAngle: String = ""
    
    var body: some View {
        let data = NumericalApertureCalculation()
        return Form {
            Section(header: Text("Parameters")) {
                HStack{
                    Text("Refractive Index (Medium)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 1.2", field: $mediumRefractiveIndex)
                }
                HStack {
                    Text("Acceptance Angle (Deg)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 20", field: $acceptanceAngle)
                }
            }
            Section(header: Text("Results")) {
                HStack {
                    Text("Numerical Aperture").customStyle()
                    Spacer()
                    Text(data.compute(from: .acceptanceAngle, n0: mediumRefractiveIndex, thetaA: acceptanceAngle))
                }
            }
            .navigationTitle("Numerical Aperture")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ComputeNAFromAcceptanceAngle_Previews: PreviewProvider {
    static var previews: some View {
        ComputeNAFromAcceptanceAngle()
    }
}
