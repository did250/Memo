import SwiftUI

struct Detail: View {
    @ObservedObject var memo : Memo
    @EnvironmentObject var store : MemoStore
    @State private var showComposer = false
    @State private var showDeleteAlert = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(memo.content)
                            .padding()
                        Spacer(minLength: 0)
                    }
                    Text(memo.insertDate, style: .date)
                        .padding()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("메모 보기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
                
                Button {
                    showComposer = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
                
            }
        }
        .sheet(isPresented: $showComposer) {
            Compose(memo: memo)
        }
        .alert("삭제 확인", isPresented: $showDeleteAlert) {
            Button(role: .destructive) {
                store.delete(memo: memo)
                dismiss()
            } label: {
                Text("삭제")
            }
        } message: {
            Text("메모를 삭제할까요?")
        }
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Detail(memo: Memo(content: "test"))
                .environmentObject(MemoStore())
        }
    }
}
