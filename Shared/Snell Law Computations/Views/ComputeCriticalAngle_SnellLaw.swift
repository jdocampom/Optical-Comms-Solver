//
//  ComputeCriticalAngle_SnellLaw.swift
//  Optical Comms Solver (iOS)
//
//  Created by Juan Diego Ocampo on 10/25/21.
//

import SwiftUI

struct ComputeCriticalAngle_SnellLaw: View {
    
    @State var coreRefractiveIndex: String = ""
    @State var claddingRefractiveIndex: String = ""
    
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
            }
            Section(header: Text("Results")) {
                HStack {
                    Text("Critical Angle (Deg)").customStyle()
                    Spacer()
                    Text(data.computeCriticalAngle(n1: coreRefractiveIndex, n2: claddingRefractiveIndex))
                }
            }
        }
        .navigationTitle("Critical Angle")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ComputeCriticalAngle_SnellLaw_Previews: PreviewProvider {
    static var previews: some View {
        ComputeCriticalAngle_SnellLaw()
    }
}
