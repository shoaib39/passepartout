//
//  AboutView.swift
//  Passepartout
//
//  Created by Davide De Rosa on 8/23/24.
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
import CommonUtils
import PassepartoutKit
import SwiftUI

struct AboutView: View {

    @EnvironmentObject
    var iapManager: IAPManager

    let profileManager: ProfileManager

    @Binding
    var navigationRoute: AboutRouterView.NavigationRoute?

    var body: some View {
        listView
    }
}

extension AboutView {
    var creditsLink: some View {
        navLink(Strings.Views.About.Credits.title, to: .credits)
    }

    var diagnosticsLink: some View {
        navLink(Strings.Views.Diagnostics.title, to: .diagnostics)
    }

    var donateLink: some View {
        navLink(Strings.Views.Donate.title, to: .donate)
    }

    var linksLink: some View {
        navLink(Strings.Views.About.Links.title, to: .links)
    }
}

private extension AboutView {
    func navLink(_ title: String, to route: AboutRouterView.NavigationRoute) -> some View {
        NavigationLink(title, value: route)
    }
}

#Preview {
    AboutView(
        profileManager: .mock,
        navigationRoute: .constant(nil)
    )
    .withMockEnvironment()
}
