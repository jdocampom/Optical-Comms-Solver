//
//  ComputeAcceptanceAngleFromNA.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/25/21.
//

import SwiftUI

struct ComputeAcceptanceAngleFromNA: View {
    
    @State var mediumRefractiveIndex: String = ""
    @State var coreRefractiveIndex: String = ""
    @State var numericalAperture: String = ""
    
    var body: some View {
        let data = MaxAcceptanceAngleCalculation()
        return Form {
            Section(header: Text("Parameters")) {
                HStack{
                    Text("Refractive Index (Medium)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 1.2", field: $mediumRefractiveIndex)
                }
                HStack{
                    Text("Refractive Index (Core)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 1.5", field: $coreRefractiveIndex)
                }
                HStack {
                    Text("Numerical Aperture").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 0.2", field: $numericalAperture)
                }
            }
            Section(header: Text("Results")) {
                HStack {
                    Text("Maximum Acceptance Angle (Deg)").customStyle()
                    Spacer()
                    Text(data.compute(from: .numericalAperture, n0: mediumRefractiveIndex, n1: coreRefractiveIndex, na: numericalAperture))
                }
            }
            .navigationTitle("Maximum Acceptance Angle")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ComputeAcceptanceAngleFromNA_Previews: PreviewProvider {
    static var previews: some View {
        ComputeAcceptanceAngleFromNA()
    }
}
