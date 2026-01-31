#include <QApplication>
#include <QLabel>
#include <QWidget>
#include <QVBoxLayout>

int main(int argc, char *argv[]) {
    // 强制告诉 Qt 我们在 Wayland 下运行，省得去配环境变量
    qputenv("QT_QPA_PLATFORM", "wayland");

    QApplication app(argc, argv);

    QWidget window;
    window.setWindowTitle("YDP Test");
    window.resize(400, 200);

    QVBoxLayout *layout = new QVBoxLayout(&window);
    QLabel *label = new QLabel("Hello DictPen!\nQt 5.15.2 is Running!", &window);
    
    label->setAlignment(Qt::AlignCenter);
    label->setStyleSheet("font-size: 20px; color: blue;");
    layout->addWidget(label);

    window.show();
    return app.exec();
}