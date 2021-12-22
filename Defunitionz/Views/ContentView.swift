//
//  ContentView.swift
//  Defunitionz
//
//  Created by Conqueriings on 22/12/21.
//

import SwiftUI

struct ContentView: View {
 
    @State var isNewDefinitionPresented = false
    @State var showSheet: Bool = false

    //    @Environment(\.presentationMode) var presentationMode
    
    
    @State var definition = Definition(name: "", description: "")
    @Binding var definitions: [Definition]
    
    @State var searchText = ""
    @State var searching = false
    
    var body: some View {
        
        
        NavigationView {
            List {
                
                ForEach(definitions) { definition in
                    let definitationIndex = definitions.firstIndex(of: definition)!
                    
                    NavigationLink(destination: DefinitationDetailView(definition: $definitions[definitationIndex])) {
                        
                        HStack {
                            Text(definition.name)
                        }
                    }
                }
                .onDelete { offsets in
                    definitions.remove(atOffsets: offsets)
                }.onMove { source, destination in
                    definitions.move(fromOffsets: source, toOffset: destination)
                }
            }
            .navigationTitle("Defunitionz")
    
            .toolbar {
                //edit
                ToolbarItem(placement: .navigation) {
                    EditButton().foregroundColor(.gray)
                }
                //
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isNewDefinitionPresented = true
                    }, label: {
                        Image(systemName: "plus").foregroundColor(.gray)
                    })
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showSheet.toggle()
                    }, label: {
                        Image(systemName: "gear").foregroundColor(.gray)
                    })
                }
               
            }
            .halfSheet(showSheet: $showSheet) {
                NavigationView {
                    List {
                        Section {
                            HStack {
                                Image(systemName: "person.fill").foregroundColor(.gray)
                                Text("Made by ")
                                Spacer()
                                Text("Wei Xuan")
                            }
                            HStack {
                                Image(systemName: "gear").foregroundColor(.gray)
                                Text("Version")
                                Spacer()
                                Text("1.0")
                            }
                            
                        }
                    }
                    .navigationTitle("Information")
                    
                }
                .ignoresSafeArea()
            }onEnd: {
                print("Dismissed")
            }.sheet(isPresented: $isNewDefinitionPresented) {
                NewDefinitationView(definitions: $definitions)
            }
            
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(definitions: .constant([]))
    }
}
