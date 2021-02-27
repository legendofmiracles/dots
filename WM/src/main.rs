#[macro_use]
extern crate penrose;
use penrose::{
    contrib::{extensions::Scratchpad, hooks::AutoSetMonitorsViaXrandr, layouts::paper},
    core::{
        data_types::RelativePosition,
        helpers::index_selectors,
        hooks::Hook,
        layout::{bottom_stack, monocle, side_stack, Layout, LayoutConf},
        xconnection::XConn,
    },
    draw::Color,
    logging_error_handler,
    xcb::{new_xcb_backed_window_manager, XcbHooks},
    Backward, Config, Forward, Less, More, Result, Selector, WindowManager,
};

use simplelog::{LevelFilter, SimpleLogger};

struct MeHooks {}

impl<X: XConn> Hook<X> for MeHooks {
    fn workspace_change(
        &mut self,
        wm: &mut WindowManager<X>,
        previous_workspace: usize,
        new_workspace: usize,
    ) -> Result<()> {
        std::process::Command::new("bar.py")
            .arg(format!("{}", new_workspace))
            .spawn()?;
        Ok(())
    }
}

fn main() -> penrose::Result<()> {
    if let Err(e) = SimpleLogger::init(LevelFilter::Info, simplelog::Config::default()) {
        panic!("unable to set log level: {}", e);
    };
    let mut config_builder = Config::default().builder();

    // Default number of clients in the main layout area
    let n_main = 1;

    // Default percentage of the screen to fill with the main area of the layout
    let ratio = 0.6;

    let config = config_builder
        .focused_border(0xFF217C)?
        .unfocused_border(0x00000)?
        .bar_height(14)
        .layouts(vec![
            Layout::new("[side]", LayoutConf::default(), side_stack, n_main, ratio),
            Layout::new("[botm]", LayoutConf::default(), bottom_stack, n_main, ratio),
            Layout::new("[papr]", LayoutConf::default(), paper, n_main, ratio),
            Layout::new("[mono]", LayoutConf::default(), monocle, n_main, ratio),
            Layout::floating("[----]"),
        ])
        .build()
        .unwrap();

    let scratchpad = Scratchpad::new("alacritty", 0.5, 0.5).get_hook();
    let hooks: XcbHooks = vec![
        Box::new(MeHooks {}),
        penrose::contrib::hooks::LayoutSymbolAsRootName::new(),
        scratchpad.get_hook(),
        AutoSetMonitorsViaXrandr::new("eDP-1", "DP-1-1", RelativePosition::Right),
    ];

    let key_bindings = gen_keybindings! {

        // cycle between clients
        "M-n" => run_internal!(cycle_client, Forward);
        "M-e" => run_internal!(cycle_client, Backward);

        // move clients
        "M-S-n" => run_internal!(drag_client, Forward);
        "M-S-e" => run_internal!(drag_client, Backward);

        // things
        "M-S-q" => run_internal!(kill_client);
        "M-Tab" => run_internal!(toggle_workspace);
        "M-g" => run_internal!(cycle_layout, Forward);
        "M-S-g" => run_internal!(cycle_layout, Backward);
        "M-Up" => run_internal!(update_max_main, More);
        "M-Down" => run_internal!(update_max_main, Less);
        "M-Right" => run_internal!(update_main_ratio, More);
        "M-Left" => run_internal!(update_main_ratio, Less);
        "M-f" => run_internal!(toggle_client_fullscreen, &Selector::Focused);

        // applications
        "M-d" => run_external!("rofi_pre");
        "M-Return" => run_external!("alacritty");
        "M-q" => run_external!("flameshot gui");
        "M-y" => run_external!("toggle_mute.sh");
        "M-r" => run_external!("text_from_image");

        // scratchpads
        "M-z" => scratchpad.toggle();

        map: { "1", "2", "3", "4", "5", "6", "7", "8", "9" } to_index_selectors(9) => {
            "M-{}" => focus_workspace [ REF ];
            "M-S-{}" => client_to_workspace [ REF ];
        };
    };

    let mut wm = new_xcb_backed_window_manager(config, hooks, logging_error_handler())?;
    wm.grab_keys_and_run(key_bindings, map! {})
}
