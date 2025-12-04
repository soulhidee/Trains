////
////  Test.swift
////  Trains
////
////  Created by Даниил on 04.12.2025.
////
//
//
//import SwiftUI
//
//struct DirectoryServiceTestView: View {
//    @State private var cities: [DirectoryCity] = []
//    @State private var isLoading = false
//    @State private var errorMessage: String?
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Тест DirectoryService")
//                .font(. system(size: 20, weight: .bold))
//            
//            Button(action: {
//                Task {
//                    await loadCities()
//                }
//            }) {
//                Text("Загрузить города")
//                    .font(.system(size: 16, weight: .semibold))
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(8)
//            }
//            
//            if isLoading {
//                VStack(spacing: 16) {
//                    ProgressView()
//                    Text("Загрузка...")
//                }
//            } else if let error = errorMessage {
//                VStack(spacing: 12) {
//                    Text("❌ Ошибка:")
//                        .font(.system(size: 14, weight: .semibold))
//                    Text(error)
//                        .font(. system(size: 12))
//                        .foregroundColor(.red)
//                }
//                .padding()
//                .background(Color.red.opacity(0.1))
//                .cornerRadius(8)
//            } else if !cities.isEmpty {
//                VStack(alignment: .leading, spacing: 12) {
//                    Text("✅ Загружено городов: \(cities.count)")
//                        .font(.system(size: 14, weight: .semibold))
//                        .foregroundColor(.green)
//                    
//                    Divider()
//                    
//                    List(cities, id: \.self) { city in
//                        Text(city.title)
//                            .font(.system(size: 14))
//                    }
//                }
//            }
//            
//            Spacer()
//        }
//        .padding()
//    }
//    
//    private func loadCities() async {
//        isLoading = true
//        errorMessage = nil
//        
//        do {
//            print("🔄 Начинаем загрузку городов...")
//            let fetchedCities = try await NetworkManager.shared.getAllCities()
//            print("✅ Города загружены: \(fetchedCities.count)")
//            
//            await MainActor.run {
//                self.cities = fetchedCities
//                self.isLoading = false
//            }
//        } catch {
//            print("❌ Ошибка: \(error.localizedDescription)")
//            await MainActor.run {
//                self.errorMessage = error.localizedDescription
//                self.isLoading = false
//            }
//        }
//    }
//}
//
//#Preview {
//    DirectoryServiceTestView()
//}
