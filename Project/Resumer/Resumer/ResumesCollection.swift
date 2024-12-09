//
//  ResumesView.swift
//  Resumer
//
//  Created by Danila Kokin on 11/27/24.
//

import SwiftUI

struct ResumesCollection: View {
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]
    
    let resumes: [ResumeInstance] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    NavigationLink(destination: ResumeCreationView()) {
                        AddNewResumeItem()
                            .scaleEffectOnPressGesture()
                    }
                    .buttonStyle(PlainButtonStyle())
                    ForEach(resumes) { resume in
                        NavigationLink(destination: EmptyView()) {
                            ResumeItem(resume: resume)
                                .scaleEffectOnPressGesture()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 20)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Resumes")
            .background(.black.opacity(0.04))
        }
    }
}

struct AddNewResumeItem: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .stroke(Color.black.opacity(0.04), lineWidth: 1)
            VStack {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.black.opacity(0.5))
                Text("New resume")
                    .fontDesign(.rounded)
                    .font(.system(size: 16))
                    .foregroundStyle(.black.opacity(0.5))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(210/297, contentMode: .fit)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 12)
    }
}

struct ResumeItem: View {
    var resume: ResumeInstance
    
    var body: some View {
        VStack(spacing: 4) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .stroke(Color.black.opacity(0.04), lineWidth: 1)
                    .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 12)
                if let jobTitle = resume.profile?.basicInfoBlock?.jobTitle {
                    Text(jobTitle)
                        .fontDesign(.rounded)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.white)
                        .padding(6)
                        .background(.black)
                        .cornerRadius(4)
                        .offset(x: 8, y: 16)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(210/297, contentMode: .fit)
        }
    }
}

#Preview {
    ResumesCollection()
}
