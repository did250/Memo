import SwiftUI

struct Compose: View {
    @EnvironmentObject var store:MemoStore
    @State private var content:String = ""
    @Environment(\.dismiss) var dismiss
    
    var memo : Memo? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $content)
                    .padding()
                    .onAppear {
                        if let memo = memo {
                            content = memo.content
                        }
                    }
            }
            .navigationTitle(memo != nil ? "Edit" : "New Memo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading ) {
                    Button {
                        dismiss()
                    }
                    label : {
                        Text("Cancel")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing ) {
                    Button {
                        if let memo = memo {
                            store.update(memo: memo, content: content)
                        }
                        else {
                            store.insert(memo: content)
                        }
                        dismiss()
                    }
                    label : {
                        Text("Save")
                    }
                }
            }
        }
    }
}

struct Compose_Previews: PreviewProvider {
    static var previews: some View {
        Compose()
            .environmentObject(MemoStore())
    }
}
