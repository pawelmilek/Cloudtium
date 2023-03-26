//
//  SearchLocationViewModel.swift
//  Cloudtium
//
//  Created by Pawel Milek on 5/6/23.
//

import Foundation
import Combine
import MapKit

final class SearchLocationViewModel: NSObject, ObservableObject {
  enum Status: Equatable {
    case idle
    case noResults
    case isSearching
    case error(String)
    case result
  }

  @Published var queryFragment: String = ""
  @Published private(set) var status: Status = .idle
  @Published private(set) var results: [SearchLocationResultModel] = []
  @Published private(set) var places: [LocationModel] = []

  private var queryCancellable: AnyCancellable?
  private lazy var searchCompleter: MKLocalSearchCompleter = {
    let completer = MKLocalSearchCompleter()
    completer.pointOfInterestFilter = .excludingAll
    return completer
  }()

  override init() {
    super.init()
    self.searchCompleter.delegate = self

    self.queryCancellable = $queryFragment
      .receive(on: DispatchQueue.main)
      .debounce(for: .milliseconds(250), scheduler: RunLoop.main, options: nil)
      .sink(receiveValue: { fragment in
        self.status = .isSearching

        if !fragment.isEmpty {
          self.searchCompleter.queryFragment = fragment

        } else {
          self.status = .idle
          self.results = []
        }
      })
  }

  func getPlace(from address: SearchLocationResultModel) {
    let request = MKLocalSearch.Request()
    let title = address.title
    let subTitle = address.subtitle

    request.naturalLanguageQuery = subTitle.contains(title)
    ? subTitle : title + ", " + subTitle

    Task {
      let response = try await MKLocalSearch(request: request).start()

      await MainActor.run {
        self.places = response.mapItems.map { LocationModel(placemark: $0.placemark) }
      }
    }
  }
}

// MARK: - MKLocalSearchCompleterDelegate
extension SearchLocationViewModel: MKLocalSearchCompleterDelegate {

  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    results = completer.results.map { SearchLocationResultModel(title: $0.title, subtitle: $0.subtitle) }
    status = completer.results.isEmpty ? .noResults : .result
    debugPrint(results)
  }

  func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
    status = .error(error.localizedDescription)
  }

}
