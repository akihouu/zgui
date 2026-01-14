const gui = @import("gui.zig");

// This call will install Win32 callbacks to handle GUI interactions.
pub fn init(
    hwnd: *const anyopaque, // HWND
) void {
    if (!ImGui_ImplWin32_Init(hwnd)) {
        unreachable;
    }
}

pub fn initOpenGL(
    hwnd: *const anyopaque, // HWND
) void {
    if (!ImGui_ImplWin32_InitForOpenGL(hwnd)) {
        unreachable;
    }
}

pub fn deinit() void {
    ImGui_ImplWin32_Shutdown();
}

pub fn newFrame() void {
    ImGui_ImplWin32_NewFrame();
}

/// Win32 message handler. Call from your application's message handler.
/// Returns non-zero if the message was consumed by ImGui.
pub fn wndProcHandler(
    hwnd: *const anyopaque, // HWND
    msg: c_uint, // UINT
    wparam: usize, // WPARAM
    lparam: isize, // LPARAM
) isize {
    return ImGui_ImplWin32_WndProcHandler(hwnd, msg, wparam, lparam);
}

// DPI-related helpers (optional)
// - Use to enable DPI awareness without having to create an application manifest.

pub fn enableDpiAwareness() void {
    ImGui_ImplWin32_EnableDpiAwareness();
}

pub fn getDpiScaleForHwnd(hwnd: *const anyopaque) f32 {
    return ImGui_ImplWin32_GetDpiScaleForHwnd(hwnd);
}

pub fn getDpiScaleForMonitor(monitor: *const anyopaque) f32 {
    return ImGui_ImplWin32_GetDpiScaleForMonitor(monitor);
}

// Transparency related helpers (optional) [experimental]
// - Use to enable alpha compositing transparency with the desktop.
// - Use together with e.g. clearing your framebuffer with zero-alpha.

pub fn enableAlphaCompositing(hwnd: *const anyopaque) void {
    ImGui_ImplWin32_EnableAlphaCompositing(hwnd);
}

// Those functions are defined in `imgui_impl_win32.cpp`.
extern fn ImGui_ImplWin32_Init(hwnd: *const anyopaque) bool;
extern fn ImGui_ImplWin32_InitForOpenGL(hwnd: *const anyopaque) bool;
extern fn ImGui_ImplWin32_Shutdown() void;
extern fn ImGui_ImplWin32_NewFrame() void;
extern fn ImGui_ImplWin32_WndProcHandler(hwnd: *const anyopaque, msg: c_uint, wparam: usize, lparam: isize) isize;
extern fn ImGui_ImplWin32_EnableDpiAwareness() void;
extern fn ImGui_ImplWin32_GetDpiScaleForHwnd(hwnd: *const anyopaque) f32;
extern fn ImGui_ImplWin32_GetDpiScaleForMonitor(monitor: *const anyopaque) f32;
extern fn ImGui_ImplWin32_EnableAlphaCompositing(hwnd: *const anyopaque) void;
