//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Даниил on 16.10.2025.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
//            testFetchStations()
//            testFetchCopyright()
//            testFetchSchedule()
//            testFetchStationSchedule()
//            testFetchRouteStations()
//            testFetchNearestCity()
//            testFetchCarrierInfo()
            testFetchStationsList()
        }
    }
    
    func testFetchStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = NearestStationsService(
                    client: client,
                    apiKey: APIKeyManager.shared.getAPIKey()
                )
                
                print("Fetching stations...")
                
                let stations = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                
                print("Successfully fetched stations \(stations)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func testFetchCopyright() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = CopyrightService(
                    client: client,
                    apiKey: APIKeyManager.shared.getAPIKey()
                )
                
                print("Fetching copyright...")
                
                let copyright = try await service.getCopyright(format: "json")
                
                print("Successfully fetched copyright:\(copyright)")
                
            } catch {
                print("Error fetching copyright: \(error)")
            }
        }
    }
    
    func testFetchSchedule() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = ScheduleSearchService(
                    client: client,
                    apiKey: APIKeyManager.shared.getAPIKey()
                )
                
                print("Fetching schedule...")
                
                let schedule = try await service.getScheduleBetweenStations(
                    from: "c146",
                    to: "c213",
                    date: "2025-10-23"
                )
                
                print("Successfully fetched schedule: \(schedule)")
            } catch {
                print("Error fetching schedule: \(error)")
            }
        }
    }
    
    func testFetchStationSchedule() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = StationScheduleService(
                    client: client,
                    apiKey: APIKeyManager.shared.getAPIKey()
                )
                
                print("Fetching station schedule...")
                
                let schedule = try await service.getStationSchedule(
                    station: "s9602494",
                    date: "2025-10-24"
                )
                
                print("Successfully fetched station schedule: \(schedule)")
            } catch {
                print("Error fetching station schedule: \(error)")
            }
        }
    }
    
    func testFetchRouteStations() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = RouteStationsService(
                    client: client,
                    apiKey: APIKeyManager.shared.getAPIKey()
                )
                
                print("Fetching route stations...")
                
                let routeStations = try await service.getRouteStations(
                    uid: "021A_6_2",
                    lang: "ru_RU",
                    showSystems: "all"
                )
                
                print("Successfully fetched route stations: \(routeStations)")
            } catch {
                print("Error fetching route stations: \(error)")
            }
        }
    }
    
    func testFetchNearestCity() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = NearestSettlementService(
                    client: client,
                    apikey: APIKeyManager.shared.getAPIKey()
                )
                print("Fetching stations...")
                let stations = try await service.getNearestCity(
                    lat: 50.440046,
                    lng: 40.4882367,
                    distance: 50
                )
                print("Successfully fetched stations: \(stations)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    func testFetchCarrierInfo() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                
                let service = CarrierService(
                    client: client,
                    apiKey: APIKeyManager.shared.getAPIKey()
                )
                
                print("Fetching carrier info...")
                
                let carrier = try await service.getCarrierInfo(code: "680", system: "iata")
                
                print("Successfully fetched carrier: \(carrier)")
            } catch {
                print("Error fetching carrier: \(error)")
            }
        }
    }
    func testFetchStationsList() {
        Task {
            do {
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport()
                )
                let service = AllStationsService(
                    client: client,
                    apiKey: APIKeyManager.shared.getAPIKey()
                )
                print("Fetching allStations...")
                let allStations = try await service.getAllStations(
                )
                print("Successfully fetched allStations")
            } catch {
                print("Error fetching allStations: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
