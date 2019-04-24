using Gtk;
using WebKit;

namespace OpenXbox.Client {
    [GtkTemplate (ui = "/com/github/gffranco/openxboxclient/openxbox.glade")]
    public class MainWindow : Gtk.ApplicationWindow {
        [GtkChild] private WebView webkitview;
        [GtkChild] private Button refreshButton;

        public MainWindow (Application app) {
            ConfigureMainWindow(app);
            ConfigureWebView();
            ConfigureRefreshButton();
        }

        private void ConfigureWebView() {
            this.webkitview.load_uri ("http://openxbox.org");
        }

        private void ConfigureMainWindow(Application app) {
            this.set_default_size (900, 640);
            this.set_application (app);
        }

        private void ConfigureRefreshButton() {
            refreshButton.clicked.connect(() => {
                LoginWindow login = new LoginWindow();
                login.show_all();
			});
        }
    }
}
