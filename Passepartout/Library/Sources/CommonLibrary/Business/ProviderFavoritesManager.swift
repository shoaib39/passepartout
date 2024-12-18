//
//  ProviderFavoritesManager.swift
//  Passepartout
//
//  Created by Davide De Rosa on 10/26/24.
//  Copyright (c) 2024 Davide De Rosa. All rights reserved.
//
//  https://github.com/passepartoutvpn
//
//  This file is part of Passepartout.
//
//  Passepartout is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Passepartout is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with Passepartout.  If not, see <http://www.gnu.org/licenses/>.
//

import Foundation

@MainActor
public final class ProviderFavoritesManager: ObservableObject {
    private let defaults: UserDefaults

    private var allFavorites: ProviderFavoriteServers

    public var moduleId: UUID {
        didSet {
            guard let rawValue = defaults.string(forKey: AppPreference.providerFavoriteServers.key) else {
                allFavorites = ProviderFavoriteServers()
                return
            }
            allFavorites = ProviderFavoriteServers(rawValue: rawValue) ?? ProviderFavoriteServers()
        }
    }

    public var serverIds: Set<String> {
        get {
            allFavorites.servers(forModuleWithId: moduleId)
        }
        set {
            objectWillChange.send()
            allFavorites.setServers(newValue, forModuleWithId: moduleId)
        }
    }

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        allFavorites = ProviderFavoriteServers()
        moduleId = UUID()
    }

    public func save() {
        defaults.set(allFavorites.rawValue, forKey: AppPreference.providerFavoriteServers.key)
    }
}
