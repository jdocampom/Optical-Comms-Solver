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
