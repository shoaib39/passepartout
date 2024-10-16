//
//  AppError+L10n.swift
//  Passepartout
//
//  Created by Davide De Rosa on 8/27/24.
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

import CommonLibrary
import Foundation
import PassepartoutKit
import UtilsLibrary

extension AppError: LocalizedError {
    var errorDescription: String? {
        let V = Strings.Errors.App.self
        switch self {
        case .emptyProfileName:
            return V.emptyProfileName

        case .malformedModule(let module, let error):
            return V.malformedModule(module.typeDescription, error.localizedDescription)

        case .ipModuleRequiresConnection:
            return V.ipModuleRequiresConnection

        case .multipleConnectionModules:
            return V.multipleConnectionModules

        case .permissionDenied:
            return V.default

        case .generic(let error):
            return error.localizedDescription
        }
    }
}

// MARK: - App side

extension PassepartoutError: LocalizedError {
    public var errorDescription: String? {
        switch code {
        case .invalidFields:
            guard let fields = userInfo as? [String: String?] else {
                return nil
            }
            let fieldsDescription = fields
                .map {
                    "\($0)=\($1?.description ?? "")"
                }
                .joined(separator: ",")

            return Strings.Errors.App.Passepartout.invalidFields(fieldsDescription)

        case .parsing:
            return reason?.localizedDescription ?? Strings.Errors.App.Passepartout.parsing

        case .corruptProviderModule:
            return Strings.Errors.App.Passepartout.corruptProviderModule(reason?.localizedDescription ?? "")

        case .unhandled:
            return reason?.localizedDescription

        default:
            return Strings.Errors.App.Passepartout.default(code.rawValue)
        }
    }
}

// MARK: - Tunnel side

extension PassepartoutError.Code: LocalizableEntity {
    public var localizedDescription: String {
        let V = Strings.Errors.Tunnel.self
        switch self {
        case .authentication:
            return V.auth

        case .crypto:
            return V.encryption

        case .dnsFailure:
            return V.dns

        case .timeout:
            return V.timeout

        case .OpenVPN.compressionMismatch:
            return V.compression

        case .OpenVPN.noRouting:
            return V.routing

        case .OpenVPN.serverShutdown:
            return V.shutdown

        case .OpenVPN.tlsFailure:
            return V.tls

        default:
            return V.generic
        }
    }
}
