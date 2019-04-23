using Gtk;
using WebKit;
using Soup;
using XboxWebApi.Authentication.Model;

namespace OpenXbox.Client {
    [GtkTemplate (ui = "/com/github/gffranco/openxboxclient/login.glade")]
    public class LoginWindow : Gtk.Window {
        [GtkChild] private WebView webkitview;
        [GtkChild] private TextView log;

        public LoginWindow () {
            ConfigureLoginWindow();
            ConfigureWebView();
        }

        private void ConfigureWebView() {
            webkitview.load_uri (build_auth_url());
            webkitview.load_changed.connect((event) => {
                if(event == LoadEvent.REDIRECTED) {
                    log_message(webkitview.get_uri());
                }
            }); 
        }

        private void ConfigureLoginWindow() {
            this.set_default_size (640, 480);
        }

        [GtkCallback]
        public void on_login_show() {
            log_message ("Starting authentication");
            log_message (build_auth_url ());
        }



        private void log_message(string msg) {
            log.buffer.text += msg + "\n";
        }

        private string build_auth_url() {
            URI uri = new URI("https://login.live.com");
            uri.set_path("/oauth20_authorize.srf");
            uri.set_query_from_form(new
                                    WindowsLiveAuthenticationQuery().get_query());
            return uri.to_string(false);
        }
    }
}
