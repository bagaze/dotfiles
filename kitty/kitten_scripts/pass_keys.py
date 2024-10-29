import re

from kittens.tui.handler import result_handler
from kitty.key_encoding import KeyEvent, parse_shortcut

def is_window_vim(window, vim_id):
    fp = window.child.foreground_processes
    return any(re.search(vim_id, p['cmdline'][0] if len(p['cmdline']) else '', re.I) for p in fp)

def encode_key_mapping(window, key_mapping):
    mods, key = parse_shortcut(key_mapping)
    event = KeyEvent(
        mods=mods,
        key=key,
        shift=bool(mods & 1),
        alt=bool(mods & 2),
        ctrl=bool(mods & 4),
        super=bool(mods & 8),
        hyper=bool(mods & 16),
        meta=bool(mods & 32),
    ).as_window_system_event()

    return window.encoded_key(event)

def main():
    pass

@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
    cmd = args[1] # bottom, top, left, right, copy, paste
    key_mapping = args[2] # ctrl+j, ctrl+k, ctrl+h, ctrl+l, ctrl+c, ctrl+v
    vim_id = args[3] if len(args) > 3 else "n?vim"

    window = boss.window_id_map.get(target_window_id)

    if window is None:
        return
    if is_window_vim(window, vim_id):
        for keymap in key_mapping.split(">"):
            encoded = encode_key_mapping(window, keymap)
            window.write_to_child(encoded)
    elif cmd == "copy":  # this is new
        window.copy_and_clear_or_interrupt()
    elif cmd == "paste": # this is new
        window.paste_selection_or_clipboard()
    else:
        boss.active_tab.neighboring_window(cmd)
