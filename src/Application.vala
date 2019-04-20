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

namespace openxbox.client {
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

            /* var builder = new Builder (); */
            /* try { */
            /*     builder.add_from_file ("../data/ui/openxbox.glade"); */
            /*     builder.connect_signals (null); */
            /*  */
            /*     var view = builder.get_object("webkit-view") as WebView; */
            /*     view.load_uri ("http://openxbox.org"); */
            /*  */
            /*     var window = builder.get_object ("main") as ApplicationWindow; */
            /*     window.set_application(this); */
            /*     window.show_all ();  */
            /* } */
            /* catch (Error e) { */
            /*     stderr.printf ("Could not load UI: %s\n", e.message); */
            /* } */

            var window = new MainWindow (this);
            window.show_all ();
        }

        public static int main (string[] args) {
            var app = new openxbox.client.Application ();
            return app.run (args);
        }

    }
}
