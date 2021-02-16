#[macro_use]
extern crate penrose;
use penrose::{
    contrib::extensions::Scratchpad,
    core::{helpers::index_selectors, hooks::Hook, xconnection::XConn},
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
        std::process::Command::new("notify-send")
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

    let config = config_builder
        .focused_border(0xFF217C)
        .unfocused_border(0x00000)
        .bar_height(14)
        .build()
        .unwrap();

    let scratchpad = Scratchpad::new("alacritty", 0.5, 0.5).get_hook();
    let hooks: XcbHooks = vec![
        Box::new(MeHooks {}),
        penrose::contrib::hooks::LayoutSymbolAsRootName::new(),
        scratchpad.get_hook(),
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
        "M-grave" => run_internal!(cycle_layout, Forward);
        "M-S-grave" => run_internal!(cycle_layout, Backward);
        "M-A-Up" => run_internal!(update_max_main, More);
        "M-A-Down" => run_internal!(update_max_main, Less);
        "M-A-Right" => run_internal!(update_main_ratio, More);
        "M-A-Left" => run_internal!(update_main_ratio, Less);
        "M-f" => run_internal!(toggle_client_fullscreen, &Selector::Focused);

        // applications
        "M-d" => run_external!("rofi_pre");
        "M-Return" => run_external!("alacritty");
        "M-q" => run_external!("flameshot gui");

        // scratchpads
        "M-z" => scratchpad.toggle();

        refmap [ 1..10 ] in {
            "M-{}" => focus_workspace [ index_selectors(9) ];
            "M-S-{}" => client_to_workspace [ index_selectors(9) ];
        };
    };

    let mut wm = new_xcb_backed_window_manager(config, hooks, logging_error_handler())?;
    wm.grab_keys_and_run(key_bindings, map! {})
}
