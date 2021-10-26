//
//  ContentView.swift
//  Shared
//
//  Created by Juan Diego Ocampo on 10/15/21.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Domain Conversions")) {
                    List {
                        NavigationLink(destination: OpticalToElectrical()) {
                            Text("Optical to Electrical")
                        }
                    }
                    List {
                        NavigationLink(destination: ElectricalToOptical()) {
                            Text("Electrical to Optical")
                        }
                    }
                }
                Section(header: Text("Snell Law Computations")) {
                    List {
                        NavigationLink(destination: RefractiveIndexFromPhaseVelocity()) {
                            Text("Refractive Index")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeCoreRefractiveIndex_SnellLaw()) {
                            Text("Core Refractive Index")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeCladdingRefractiveIndex_SnellLaw()) {
                            Text("Cladding Refractive Index")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeIncidentAngle_SnellLaw()) {
                            Text("Incident Angle")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeTransmittedAngle_SnellLaw()) {
                            Text("Transmitted Angle")
                        }
                    }
                    List {
                        NavigationLink(destination: ComputeCriticalAngle_SnellLaw()) {
                            Text("Critical Angle")
                        }
                    }
                }
            }
            .navigationTitle("Optical Comms Solver")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
