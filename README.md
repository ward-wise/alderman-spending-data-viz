# Setup
1. Install [docker](https://docs.docker.com/get-docker/)
2. Install the (Dev Containers extension)[https://code.visualstudio.com/docs/devcontainers/tutorial#_install-the-extension] for Visual Studio Code.
3. Clone this repo from Github into a dev container (Ctrl+Shift+P "clone container").
4. Wait for the container to setup. You will get a message once the Flutter extension installs that Flutter needs to be downloaded. **Ignore this**. Flutter is already downloading in the background, it just takes a few minutes.
5. Once the terminal shows that Flutter has installed, use Ctrl+Shift+P "reload window" to reload the VS code window.
6. From the container terminal, navigate into the "alderman_spending" directory. Run the command `flutter pub get`.
   
# Run the app
1. Install the [Chrome Dart Debug extension](https://chromewebstore.google.com/detail/dart-debug-extension/eljbmlghnomdjgdjmbdekegdkbabckhm).
2. In VS Code, go to the debug settings in the left sidebar and choose the **Web Server** configuration.
3. Open the main.dart file. Run the debug configuration.
4. Wait 30 seconds to a few minutes for the dev server to spin up.
5. When the webpage opens in a new Chrome tab, activate the Dart extension on that tab.
