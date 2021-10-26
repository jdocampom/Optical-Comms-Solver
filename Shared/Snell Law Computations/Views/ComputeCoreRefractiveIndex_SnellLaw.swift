//
//  ComputeCoreRefractiveIndex_SnellLaw.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/25/21.
//

import SwiftUI

struct ComputeCoreRefractiveIndex_SnellLaw: View {
    
    @State var claddingRefractiveIndex: String = ""
    @State var incidentAngle: String = ""
    @State var transmittedAngle: String = ""
    
    var body: some View {
        let data = SnellLawComputation()
        return Form {
            Section(header: Text("Parameters")) {
                HStack{
                    Text("Refractive Index (Cladding)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 1.6", field: $claddingRefractiveIndex)
                }
                HStack{
                    Text("Incident Angle (Deg)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 20", field: $incidentAngle)
                }
                HStack {
                    Text("Transmitted Angle (Deg)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 80", field: $transmittedAngle)
                }
            }
            Section(header: Text("Results")) {
                HStack {
                    Text("Refractive Index (Core)").customStyle()
                    Spacer()
                    Text(data.computeVariable(target: .refractiveIndex1, n2: claddingRefractiveIndex, theta1: incidentAngle, theta2: transmittedAngle))
                }
            }
        }
        .navigationTitle("Core Refractive Index")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ComputeCoreRefractiveIndex_SnellLaw_Previews: PreviewProvider {
    static var previews: some View {
        ComputeCoreRefractiveIndex_SnellLaw()
    }
}
