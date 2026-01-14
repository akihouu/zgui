const gui = @import("gui.zig");
const backend_win32 = @import("backend_win32.zig");

// Re-export Win32 helpers
pub const wndProcHandler = backend_win32.wndProcHandler;
pub const enableDpiAwareness = backend_win32.enableDpiAwareness;
pub const getDpiScaleForHwnd = backend_win32.getDpiScaleForHwnd;
pub const getDpiScaleForMonitor = backend_win32.getDpiScaleForMonitor;
pub const enableAlphaCompositing = backend_win32.enableAlphaCompositing;

pub fn initWithGlSlVersion(
    hwnd: *const anyopaque, // HWND
    glsl_version: ?[:0]const u8, // e.g. "#version 130"
) void {
    backend_win32.initOpenGL(hwnd);
    ImGui_ImplOpenGL3_Init(@ptrCast(glsl_version));
}

pub fn init(
    hwnd: *const anyopaque, // HWND
) void {
    initWithGlSlVersion(hwnd, null);
}

pub fn deinit() void {
    ImGui_ImplOpenGL3_Shutdown();
    backend_win32.deinit();
}

pub fn newFrame(fb_width: u32, fb_height: u32) void {
    backend_win32.newFrame();
    ImGui_ImplOpenGL3_NewFrame();

    gui.io.setDisplaySize(@as(f32, @floatFromInt(fb_width)), @as(f32, @floatFromInt(fb_height)));
    gui.io.setDisplayFramebufferScale(1.0, 1.0);

    gui.newFrame();
}

pub fn draw() void {
    gui.render();
    ImGui_ImplOpenGL3_RenderDrawData(gui.getDrawData());
}

// Those functions are defined in 'imgui_impl_opengl3.cpp`.
extern fn ImGui_ImplOpenGL3_Init(glsl_version: [*c]const u8) void;
extern fn ImGui_ImplOpenGL3_Shutdown() void;
extern fn ImGui_ImplOpenGL3_NewFrame() void;
extern fn ImGui_ImplOpenGL3_RenderDrawData(data: *const anyopaque) void;
