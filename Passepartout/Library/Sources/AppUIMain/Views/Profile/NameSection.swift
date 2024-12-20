//
//  NameSection.swift
//  Passepartout
//
//  Created by Davide De Rosa on 9/15/24.
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

import SwiftUI

struct NameSection: View {

    @Binding
    var name: String

    let placeholder: String

    var body: some View {
        debugChanges()
        return Group {
            ThemeTextField(Strings.Global.name, text: $name, placeholder: placeholder)
                .labelsHidden()
                .themeManualInput()
        }
        .themeSection(header: Strings.Global.name)
    }
}

// MARK: - Previews

#Preview {
    struct ContentView: View {

        @State
        private var name = ""

        var body: some View {
            Form {
                NameSection(
                    name: $name,
                    placeholder: "My name"
                )
            }
            .themeForm()
        }
    }

    return ContentView()
        .withMockEnvironment()
}
