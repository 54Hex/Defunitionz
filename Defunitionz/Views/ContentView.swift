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
                        Form {
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
        ContentView(definitions: .constant([Definition(name: "1. Intro", description: "Hello. Welcome to Defunitionz, an app created in a day because it was made with a random idea."),
                                                       Definition(name: "2. Tutorial", description: "Edit allows you to delete any of your definitions. Or you could just swipe right at the definition you would want to delete/remove."),
                                            Definition(name: "3. What you can do", description: "Pretty sure there's nothing much you could do here except for adding definitions such as mathematical formulas so that you can memorise and apply it for your own studies, or you could use it to store english definitions that you are unsure of.")]))
    }
}

