//
//  ComputeIncidentAngle_SnellLaw.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/25/21.
//

import SwiftUI

struct ComputeIncidentAngle_SnellLaw: View {
    
    @State var coreRefractiveIndex: String = ""
    @State var claddingRefractiveIndex: String = ""
    @State var transmittedAngle: String = ""
    
    var body: some View {
        let data = SnellLawComputation()
        return Form {
            Section(header: Text("Parameters")) {
                HStack{
                    Text("Refractive Index (Core)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 1.6", field: $coreRefractiveIndex)
                }
                HStack{
                    Text("Refractive Index (Cladding)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 1.4", field: $claddingRefractiveIndex)
                }
                HStack {
                    Text("Transmitted Angle (Deg)").customStyle()
                    Spacer()
                    DecimalField(placeholder: "e.g.: 80", field: $transmittedAngle)
                }
            }
            Section(header: Text("Results")) {
                HStack {
                    Text("Incident Angle (Deg)").customStyle()
                    Spacer()
                    Text(data.computeVariable(target: .incidentAngle, n1: coreRefractiveIndex, n2: claddingRefractiveIndex, theta2: transmittedAngle))
                }
            }
        }
        .navigationTitle("Incident Angle")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ComputeIncidentAngle_SnellLaw_Previews: PreviewProvider {
    static var previews: some View {
        ComputeIncidentAngle_SnellLaw()
    }
}
