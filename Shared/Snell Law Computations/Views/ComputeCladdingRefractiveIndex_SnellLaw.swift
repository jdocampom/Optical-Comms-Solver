//
//  ComputeCladdingRefractiveIndex_SnellLaw.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/25/21.
//

import SwiftUI

struct ComputeCladdingRefractiveIndex_SnellLaw: View {
    
    @State var coreRefractiveIndex: String = ""
    @State var incidentAngle: String = ""
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
                    Text("Refractive Index (Cladding)").customStyle()
                    Spacer()
                    Text(data.computeVariable(target: .refractiveIndex2, n2: coreRefractiveIndex, theta1: incidentAngle, theta2: transmittedAngle))
                }
            }
        }
        .navigationTitle("Cladding Refractive Index")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ComputeCladdingRefractiveIndex_SnellLaw_Previews: PreviewProvider {
    static var previews: some View {
        ComputeCladdingRefractiveIndex_SnellLaw()
    }
}
