import SwiftUI

struct ResumesCollection: View {
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]
    
    @StateObject var viewModel: ResumesCollectionVM = .init()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    addNewResumeButton()
                    resumeItems()
                }
                .padding(.horizontal, 20)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Resumes")
            .background(Color.black.opacity(0.04))
        }
    }
    
    private func addNewResumeButton() -> some View {
        NavigationLink(destination: ResumeCreationView(resumeVM: .init())) {
            AddNewResumeItem()
                .scaleEffectOnPressGesture()
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func resumeItems() -> some View {
        ForEach(viewModel.collection) { resume in
            NavigationLink(destination: ResumeCreationView(resumeVM: resume)) {
                ResumeItem(resume: resume)
                    .scaleEffectOnPressGesture()
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct AddNewResumeItem: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black.opacity(0.04), lineWidth: 1)
                )
            VStack {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.black.opacity(0.5))
                Text("New resume")
                    .font(.system(size: 16))
                    .fontDesign(.rounded)
                    .foregroundStyle(Color.black.opacity(0.5))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(210 / 297, contentMode: .fit)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 12)
    }
}

struct ResumeItem: View {
    @StateObject var resume: ResumeCreationVM
    
    var body: some View {
        VStack(spacing: 4) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black.opacity(0.04), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 12)
                
                Text(resume.basicInfoVM.jobTitle)
                    .fontDesign(.rounded)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.white)
                    .padding(6)
                    .background(Color.black)
                    .cornerRadius(4)
                    .offset(x: 8, y: 16)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(210 / 297, contentMode: .fit)
        }
    }
}

class ResumesCollectionVM: ObservableObject {
    @Published var collection: [ResumeCreationVM] = []
    
    init(collection: [ResumeCreationVM] = []) {
        self.collection = collection
        self.collection.append(ResumeCreationVM.mock)
    }
}

#Preview {
    ResumesCollection()
}
