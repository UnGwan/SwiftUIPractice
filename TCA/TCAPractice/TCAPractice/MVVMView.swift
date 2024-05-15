//
//  MVVMView.swift
//  TCAPractice
//
//  Created by 정운관 on 5/14/24.
//

import SwiftUI

//Model
struct NumberFactModel {
    var count: Int = 0
    var numberFact: String?
}

//ViewModel
class NumberFactViewModel: ObservableObject {
    @Published var model = NumberFactModel()
    
    func incrementCount() {
        model.count += 1
    }
    
    func decrementCount() {
        model.count -= 1
    }
    
    func fetchNumberFact() {
        guard let url = URL(string: "http://numbersapi.com/\(model.count)/trivia") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let fact = String(data: data, encoding: .utf8) {
                    self.model.numberFact = fact
                }
            }
        }.resume()
    }
}

struct MVVMView: View {
    @StateObject private var viewModel = NumberFactViewModel()
    
    var body: some View {
        Form {
            Section {
                Text("\(viewModel.model.count)")
                Button("Decrement") {
                    viewModel.decrementCount()
                }
                Button("Increment") {
                    viewModel.incrementCount()
                }
            }
            
            Section {
                Button("Number fact") {
                    viewModel.fetchNumberFact()
                }
            }
            
            if let fact = viewModel.model.numberFact {
                Text(fact)
            }
        }
    }
}

#Preview {
    MVVMView()
}
