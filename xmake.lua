-- 1. 定义工具链（直接借用 Zig）
toolchain("zig-cross")
    set_kind("standalone")
    set_toolset("cc", "zig cc")
    set_toolset("cxx", "zig c++")
    set_toolset("ld", "zig cc")
    set_toolset("ar", "zig ar")
toolchain_end()

-- 2. 项目配置（直接沿用原工程的语言标准）
set_languages("cxx23", "c11")

target("hello_pen_qt")
    set_kind("binary")
    set_toolchains("zig-cross")

    -- 核心：直接把 Target 喂给编译器和链接器
    add_cxflags("-target aarch64-linux-gnu.2.27", {force = true})
    add_ldflags("-target aarch64-linux-gnu.2.27", "-static-libstdc++", {force = true})

    -- 关键路径：这里我们用最干净的方式指向你下载的 Qt 目录
    -- 假设你的 sysroot 就在项目根目录下
    add_includedirs("sysroot/include", "sysroot/include/QtCore", "sysroot/include/QtGui", "sysroot/include/QtWidgets")
    add_linkdirs("sysroot/lib")

    -- 模仿原工程链接 Qt 库
    add_links("Qt5Widgets", "Qt5Gui", "Qt5Core")

    -- 源代码
    add_files("src/*.cpp")

--
-- If you want to known more usage about xmake, please see https://xmake.io
--
-- ## FAQ
--
-- You can enter the project directory firstly before building project.
--
--   $ cd projectdir
--
-- 1. How to build project?
--
--   $ xmake
--
-- 2. How to configure project?
--
--   $ xmake f -p [macosx|linux|iphoneos ..] -a [x86_64|i386|arm64 ..] -m [debug|release]
--
-- 3. Where is the build output directory?
--
--   The default output directory is `./build` and you can configure the output directory.
--
--   $ xmake f -o outputdir
--   $ xmake
--
-- 4. How to run and debug target after building project?
--
--   $ xmake run [targetname]
--   $ xmake run -d [targetname]
--
-- 5. How to install target to the system directory or other output directory?
--
--   $ xmake install
--   $ xmake install -o installdir
--
-- 6. Add some frequently-used compilation flags in xmake.lua
--
-- @code
--    -- add debug and release modes
--    add_rules("mode.debug", "mode.release")
--
--    -- add macro definition
--    add_defines("NDEBUG", "_GNU_SOURCE=1")
--
--    -- set warning all as error
--    set_warnings("all", "error")
--
--    -- set language: c99, c++11
--    set_languages("c99", "c++11")
--
--    -- set optimization: none, faster, fastest, smallest
--    set_optimize("fastest")
--
--    -- add include search directories
--    add_includedirs("/usr/include", "/usr/local/include")
--
--    -- add link libraries and search directories
--    add_links("tbox")
--    add_linkdirs("/usr/local/lib", "/usr/lib")
--
--    -- add system link libraries
--    add_syslinks("z", "pthread")
--
--    -- add compilation and link flags
--    add_cxflags("-stdnolib", "-fno-strict-aliasing")
--    add_ldflags("-L/usr/local/lib", "-lpthread", {force = true})
--
-- @endcode
--

