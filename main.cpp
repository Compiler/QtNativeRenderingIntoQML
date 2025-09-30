#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtGui/QWindow>

#if defined(_WIN32)
#define GLFW_EXPOSE_NATIVE_WIN32
#elif defined(__APPLE__)
#define GLFW_EXPOSE_NATIVE_COCOA
#else
#define GLFW_EXPOSE_NATIVE_X11
#endif
#include <GLFW/glfw3.h>
#include <GLFW/glfw3native.h>

inline QWindow* makeForeignQWindowFromGLFW(GLFWwindow* g) {
#if defined(_WIN32)
    HWND hwnd = glfwGetWin32Window(g);
    return QWindow::fromWinId(reinterpret_cast<WId>(hwnd));
#elif defined(__APPLE__)
    id nswin = glfwGetCocoaWindow(g);               // NSWindow*
    NSView* view = [(__bridge NSWindow*)nswin contentView]; // QWindow wants NSView*
    return QWindow::fromWinId(reinterpret_cast<WId>(view));
#else
    Window xwin = glfwGetX11Window(g);              // xcb_window_t
    return QWindow::fromWinId(static_cast<WId>(xwin));
#endif
}

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API); // you'll render yourself
    GLFWwindow* gw = glfwCreateWindow(1280, 720, "GLFW", nullptr, nullptr);

    QWindow* foreign = makeForeignQWindowFromGLFW(gw);

    QQmlApplicationEngine engine;
    engine.setInitialProperties({ {"foreignWindow", QVariant::fromValue(foreign)} });

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("TestWindowing", "Main");

    return app.exec();
}
