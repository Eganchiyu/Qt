cd /home/asumi/Asumi/Projects/Qt

g++ main.cpp -o hello_qt \
  `pkg-config --cflags --libs Qt5Widgets`