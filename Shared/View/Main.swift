
import SwiftUI

struct Main: View {
    @EnvironmentObject var store : MemoStore
    @State private var showComposer : Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.list) { memo in
                    NavigationLink {
                        Detail(memo: memo)
                    } label: {
                        MemoCell(memo: memo)
                    }
                }
                .onDelete(perform: store.delete)
                
            }
            .listStyle(.plain)
            .navigationTitle("My Memo")
            .toolbar {
                Button {
                    showComposer = true
                }
                label : {
                    Image(systemName: "plus")
                }
            }
            // MARK: - isPresented 가 true 이면 클로저 실행 하고 뷰를 modal 방식으로.
             .sheet(isPresented: $showComposer) {
                Compose()
             }
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
            .environmentObject(MemoStore())
    }
}

