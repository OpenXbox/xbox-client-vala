using Gtk;
using WebKit;
using Soup;
using Json;
using XboxWebApi.Authentication;
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

            webkitview.load_changed.connect((event) => {
                if(event == LoadEvent.REDIRECTED) {
                    var redirected_uri = webkitview.get_uri();
                    log_message("Redirect: %s".printf(redirected_uri));
                    URI parsed_uri = new URI(redirected_uri);
                    var fragment = parsed_uri.get_fragment();
                    log_message("Fragments: %s".printf(fragment));
                    var query = Form.decode(fragment);
                    query.foreach((k,v) => {
                        log_message("%s: %s".printf(k,v));
                    });
                    WindowsLiveResponse wlr = new WindowsLiveResponse.from_query(query);
                    log_message("Response: %s".printf(wlr.to_string()));
                    OpenXbox.Services.auth_service = new AuthenticationService.from_windows_live_response(wlr);
                    log_message(OpenXbox.Services.auth_service.authenticate() ? "Authenticated!" : "Failed to authenticate");
                }
            }); 
        }

        private void ConfigureLoginWindow() {
            this.set_default_size (640, 480);
        }

        [GtkCallback]
        public void on_login_show() {
            log_message ("Starting authentication");
            var url = OpenXbox.Services.auth_service.get_authentication_url();
            log_message ("Loading authentication website: %s".printf(url));
            webkitview.load_uri (url);
        }

        private void log_message(string msg) {
            log.buffer.text += msg + "\n";
        }
    }
}
