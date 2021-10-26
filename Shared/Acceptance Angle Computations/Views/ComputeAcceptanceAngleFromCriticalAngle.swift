//
//  ComputeAcceptanceAngleFromCriticalAngle.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/25/21.
//

import SwiftUI

struct ComputeAcceptanceAngleFromCriticalAngle: View {
    
    @State var mediumRefractiveIndex: String = ""
    @State var coreRefractiveIndex: String = ""
    @State var criticalAngle: String = ""
    
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
                    Text("Critical Angle (Deg)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 45", field: $criticalAngle)
                }
            }
            Section(header: Text("Results")) {
                HStack {
                    Text("Maximum Acceptance Angle (Deg)").customStyle()
                    Spacer()
                    Text(data.compute(from: .criticalAngle, n0: mediumRefractiveIndex, n1: coreRefractiveIndex, theta: criticalAngle))
                }
            }
            .navigationTitle("Maximum Acceptance Angle")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ComputeAcceptanceAngleFromCriticalAngle_Previews: PreviewProvider {
    static var previews: some View {
        ComputeAcceptanceAngleFromCriticalAngle()
    }
}
