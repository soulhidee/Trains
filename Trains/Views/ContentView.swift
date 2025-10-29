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
            testFetchStations() // РАБОТАЕТ
            testFetchCopyright() // РАБОТАЕТ
            testFetchSchedule() // РАБОТАЕТ
            testFetchStationSchedule() // РАБОТАЕТ
            testFetchRouteStations() // РАБОТАЕТ
            testFetchNearestCity() // РАБОТАЕТ
            testFetchCarrierInfo() // РАБОТАЕТ
            testFetchStationsList() // РАБОТАЕТ
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
                
                let carrier = try await service.getCarrierInfo(code: "TK", system: "iata")
                
                print("Successfully fetched carrier: \(carrier)")
            } catch {
                print("Error fetching carrier: \(error)")
            }
        }
    }
    func testFetchStationsList() {
        Task {
            do {
                let configuration = URLSessionConfiguration.default
                configuration.timeoutIntervalForRequest = 120
                configuration.timeoutIntervalForResource = 300
                
                let urlSession = URLSession(configuration: configuration)
                
                let client = Client(
                    serverURL: try Servers.Server1.url(),
                    transport: URLSessionTransport(configuration: .init(session: urlSession))
                )
                
                let service = AllStationsService(
                    client: client,
                    apiKey: APIKeyManager.shared.getAPIKey()
                )
                
                print("Fetching allStations... (this may take a while)")
                
                let allStations = try await service.getAllStations()
                
                print("Successfully fetched allStations!")
                print("Total countries: \(allStations.countries?.count ?? 0)")
                
                var totalStations = 0
                if let countries = allStations.countries {
                    for country in countries {
                        if let regions = country.regions {
                            for region in regions {
                                if let settlements = region.settlements {
                                    for settlement in settlements {
                                        totalStations += settlement.stations?.count ?? 0
                                    }
                                }
                            }
                        }
                    }
                }
                print("Total stations: \(totalStations)")
                
            } catch {
                print("Error fetching allStations: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
