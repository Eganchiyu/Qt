-- 定义工具链，避免 xmake 瞎猜
toolchain("zig-cross")
    set_kind("standalone")
    -- 强制指定不检查，因为 zig 本身就是全能的
    set_toolset("cc", "zig cc")
    set_toolset("cxx", "zig c++")
    set_toolset("ld", "zig cc")
    set_toolset("ar", "zig ar")
    
    -- 这一行很关键：告诉 xmake 即使找不到标准 SDK 结构也继续
    on_check(function (toolchain)
        return true
    end)
toolchain_end()

target("hello_pen")
    -- 直接锁定你要的那台笔的参数
    add_cxflags("-target aarch64-linux-gnu.2.27", {force = true})
    add_ldflags("-target aarch64-linux-gnu.2.27", {force = true})
    
    -- 路径直接指向上次我们说的大佬 SDK
    add_rules('qt.shared')
    add_frameworks("QtWidgets", "QtGui", "QtCore")

    add_files("src/**.cpp")