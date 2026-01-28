#include <QApplication>
#include <QWidget>
#include <QLabel>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QWidget w;
    w.setWindowTitle("Hello DictPen");

    QLabel label(&w);
    label.setText("Hello Wayland + Qt");
    label.move(40, 40);

    w.resize(400, 300);
    w.show();

    return app.exec();
}