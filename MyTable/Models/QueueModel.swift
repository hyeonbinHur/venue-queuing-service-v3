//
//  QueueModel.swift
//  MyTable
//
//  Created by Pascal Couturier on 20/8/2023.
//

import Foundation

// Queue model for both restaurants and users when waiting in queue
// and confirming
/// Queue model that is used to display queue data to users
struct QueueModel: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case queueNumber
        case userId
        case venueId
        case validationCode
        case hasValidationCodeBeenUsed
        case completed
        case cancelled
    }
    
    var id = UUID()
    var queueNumber: Int
    var userId: String
    var venueId: String
    var validationCode: String
    var hasValidationCodeBeenUsed: Bool
    var completed: Bool
    var cancelled: Bool
}

// Load queue data
// TODO: add multiple queue load options based on who is logged in and what queue is being retrieved
/// Loads dummy queue data
class LoadQueueingData: ObservableObject {
    @Published var queuingData = [QueueModel]()
    
    init() {
        loadQueueingData()
    }
    
    // TODO: This currently load dummy data from a json file
    func loadQueueingData() {
        guard let url = Bundle.main.url(forResource: "QueueingData", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        let data = try? Data(contentsOf: url)
        let queuingData = try? JSONDecoder().decode([QueueModel].self, from: data!)
        self.queuingData = queuingData!
    }
}
