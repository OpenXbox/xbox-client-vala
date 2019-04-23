/*
 * Copyright (c) {{yearrange}} gabriel ()
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 *
 * Authored by: gabriel <>
 */
using Granite;
using Granite.Widgets;
using Gtk;
using WebKit;
using XboxWebApi.Authentication;

namespace OpenXbox.Client {
    public class Application : Granite.Application {

        public Application () {
            Object(
                application_id: "com.github.gffranco.openxboxclient",
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        protected override void activate () {
            var dummyView = new WebView();
            dummyView = null;

            var window = new MainWindow (this);
            window.show_all ();
        }

        public static int main (string[] args) {
            var app = new OpenXbox.Client.Application ();
            return app.run (args);
        }

    }
}
