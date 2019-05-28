using Gtk;
using Soup;
using WebKit;
using XboxWebApi.Authentication;
using XboxWebApi.Authentication.Model;

namespace OpenXbox.Client {

    [GtkTemplate (ui = "/com/github/gffranco/openxboxclient/login.glade")]
    public class LoginWindow : Gtk.Window {

        [GtkChild] private WebView webkitview;

        public LoginWindow () {
            ConfigureLoginWindow();
            ConfigureWebView();
        }

        private void ConfigureWebView() {
            webkitview.load_changed.connect((event) => {
                if(event == LoadEvent.REDIRECTED) {
                    var redirected_uri = webkitview.get_uri();
                    
                    URI parsed_uri = new URI(redirected_uri);
                    var fragment = parsed_uri.get_fragment();
                    
                    var query = Form.decode(fragment);
                    
                    WindowsLiveResponse wlr = new WindowsLiveResponse.from_query(query);
                    debug ("Response: %s", wlr.to_string());

                    OpenXbox.Services.auth_service = new AuthenticationService.from_windows_live_response(wlr);
                    info (OpenXbox.Services.auth_service.authenticate() ? "Authenticated!" : "Failed to authenticate");
                }
            }); 
        }

        private void ConfigureLoginWindow() {
            this.set_default_size (640, 480);
        }

        [GtkCallback]
        public void on_login_show() {
            info ("Starting authentication");
            var url = AuthenticationService.get_authentication_url();
            debug ("Loading authentication website: %s", url);
            webkitview.load_uri (url);
        }
    }
}
