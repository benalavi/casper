require "ffi"

module Casper
  module Native
    extend FFI::Library
    ffi_lib "xdo"

    # xdo_t * xdo_new (char *display)
    attach_function "xdo_new", [:string], :pointer

    # xdo_t * xdo_new_with_opened_display (Display *xdpy, const char *display, int close_display_when_freed)
    attach_function "xdo_new_with_opened_display" [:pointer, :string, :int], :pointer

    # const char * xdo_version (void)
    attach_function "xdo_version", [], :string

    # void xdo_free (xdo_t *xdo)
    attach_function "xdo_free", [:pointer], :void

    # int xdo_mousemove (const xdo_t *xdo, int x, int y, int screen)
    attach_function "xdo_mousemove" [:pointer, :int, :int, :int], :int

    # int xdo_mousemove_relative_to_window (const xdo_t *xdo, Window window, int x, int y)
    # XXX: Window is not a pointer - find the typedef
    attach_function "xdo_mousemove_relative_to_window" [:pointer, :pointer, :int, :int], :int
    
    # int xdo_mousemove_relative (const xdo_t *xdo, int x, int y)
    attach_function "xdo_mousemove_relative" [:pointer, :int, :int], :int

    # int xdo_mousedown (const xdo_t *xdo, Window window, int button)
    # XXX: Window != pointer
    attach_function "xdo_mousedown", [:pointer, :pointer, int], :int

    # int xdo_mouseup (const xdo_t *xdo, Window window, int button)
    # XXX: Window != pointer
    attach_function "xdo_mouseup", [:pointer, :pointer, int], :int

    # int xdo_mouselocation (const xdo_t *xdo, int *x, int *y, int *screen_num)
    # XXX: returning values like this is fun.  Need a memorypointer object I suppose?
    attach_function "xdo_mouselocation", [:pointer, :pointer, :pointer, :pointer], :int

    # int xdo_mouse_wait_for_move_from (const xdo_t *xdo, int origin_x, int origin_y)
    attach_function "xdo_mouse_wait_for_move_from", [:pointer, :int, :int], :int

    # int xdo_mouse_wait_for_move_to (const xdo_t *xdo, int dest_x, int dest_y)
    attach_function "xdo_mouse_wait_for_move_to", [:pointer, :int, :int], :int

    # int xdo_click (const xdo_t *xdo, Window window, int button)
    # XXX: Window != pointer
    attach_function "xdo_click", [:pointer, :pointer, :int], :int

    # int xdo_type (const xdo_t *xdo, Window window, char *string, useconds_t delay)
    # XXX: Window != pointer
    # XXX: Map useconds_t
    attach_function "xdo_type", [:pointer, :pointer, :string, :int], :int

    # int xdo_keysequence (const xdo_t *xdo, Window window, const char *keysequence, useconds_t delay)
    # XXX: Window != pointer
    # XXX: Map useconds_t
    attach_function "xdo_keysequence", [:pointer, :pointer, :string, :int], :int

    # int xdo_keysequence_up (const xdo_t *xdo, Window window, const char *keysequence, useconds_t delay)
    # XXX: Window != pointer
    # XXX: Map useconds_t
    attach_function "xdo_keysequence_up", [:pointer, :pointer, :string, :int], :int

    # int xdo_keysequence_down (const xdo_t *xdo, Window window, const char *keysequence, useconds_t delay)
    # XXX: Window != pointer
    # XXX: Map useconds_t
    attach_function "xdo_keysequence_down", [:pointer, :pointer, :string, :int], :int

    # int xdo_keysequence_list_do (const xdo_t *xdo, Window window, charcodemap_t *keys, int nkeys, int pressed, int *modifier, useconds_t delay)
    # XXX: Window != pointer
    # XXX: What"s a charcodemap_t?
    # XXX: Map useconds_t
    attach_function "xdo_keysequence_list_do", [:pointer, :pointer, :pointer, :int, :int, :pointer, :int], :int

    # int xdo_active_keys_to_keycode_list (const xdo_t *xdo, charcodemap_t **keys, int *nkeys)
    # XXX: Map useconds_t
    # XXX: What"s a pointer to pointer to charcodemap_t?
    attach_function "xdo_active_keys_to_keycode_list", [:pointer, :pointer, :pointer], :int

    # int xdo_window_wait_for_map_state (const xdo_t *xdo, Window wid, int map_state)
    # XXX: Window != pointer
    attach_function "xdo_window_wait_for_map_state", [:pointer, :pointer, :int], :int

    # int xdo_window_move (const xdo_t *xdo, Window wid, int x, int y)
    # XXX: Window != pointer
    attach_function "xdo_window_move", [:pointer, :pointer, :int, :int], :int

    # int xdo_window_setsize (const xdo_t *xdo, Window wid, int w, int h, int flags)
    # XXX: Window != pointer
    attach_function "xdo_window_setsize", [:pointer, :pointer, :int, :int, :int], :int

    # int xdo_window_setprop (const xdo_t *xdo, Window wid, const char *property, const char *value)
    # XXX: Window != pointer
    attach_function "xdo_window_setprop", [:pointer, :pointer, :string, :string], :int

    # int xdo_window_setclass (const xdo_t *xdo, Window wid, const char *name, const char *class)
    # XXX: Window != pointer
    attach_function "xdo_window_setclass", [:pointer, :pointer, :string, :string], :int

    # int xdo_window_focus (const xdo_t *xdo, Window wid)
    # XXX: Window != pointer
    attach_function "xdo_window_focus", [:pointer, :pointer] :int

    # int xdo_window_raise (const xdo_t *xdo, Window wid)
    # XXX: Window != pointer
    attach_function "xdo_window_raise", [:pointer, :pointer], :int

    # int xdo_window_get_focus (const xdo_t *xdo, Window *window_ret)
    # NOTE: This window is actually a pointer.  Watch out
    attach_function "xdo_window_get_focus", [:pointer, :pointer], :int

    # int xdo_window_wait_for_focus (const xdo_t *xdo, Window window, int want_focus)
    # XXX: Window != pointer
    attach_function "xdo_window_wait_for_focus", [:pointer, :pointer, :int], :int

    # int xdo_window_get_pid (const xdo_t *xdo, Window window)
    # XXX: Window != pointer
    attach_function "xdo_window_get_pid", [:pointer, :pointer], :int

    # int xdo_window_sane_get_focus (const xdo_t *xdo, Window *window_ret)
    # NOTE: This window is actually a pointer.  Watch out
    attach_function "xdo_window_sane_get_focus", [:pointer, :pointer], :int

    # int xdo_window_activate (const xdo_t *xdo, Window wid)
    # XXX: Window != pointer
    attach_function "xdo_window_activate", [:pointer, :pointer], :int

    # int xdo_window_wait_for_active (const xdo_t *xdo, Window window, int active)
    # XXX: Window != pointer
    attach_function "xdo_window_wait_for_active", [:pointer, :pointer, :int], :int

    # int xdo_window_map (const xdo_t *xdo, Window wid)
    # XXX: Window != pointer
    attach_function "xdo_window_map", [:pointer, :pointer], :int

    # int xdo_window_unmap (const xdo_t *xdo, Window wid)
    attach_function "xdo_window_unmap", [:pointer, :pointer], :int

    # int xdo_get_window_location (const xdo_t *xdo, Window wid, int *x_ret, int *y_ret, Screen **screen_ret)
    # XXX: Window != pointer
    # XXX: What"s a screen double pointer
    attach_function "xdo_get_window_location", [:pointer, :pointer, :pointer, :pointer, :pointer] (const xdo_t *xdo, Window wid, int *x_ret, int *y_ret, Screen **screen_ret), :int

    # int xdo_get_window_size (const xdo_t *xdo, Window wid, unsigned int *width_ret, unsigned int *height_ret)
    # XXX: Window != pointer
    attach_function "xdo_get_window_size", [:pointer, :pointer, :pointer, :pointer], :int

    # int xdo_window_get_active (const xdo_t *xdo, Window *window_ret)
    # NOTE: This window is actually a pointer.  Watch out
    attach_function "xdo_window_get_active", [:pointer, :pointer], :int

    # int xdo_set_number_of_desktops (const xdo_t *xdo, long ndesktops)
    attach_function "xdo_set_number_of_desktops", [:pointer, :long], :int

    # int xdo_get_number_of_desktops (const xdo_t *xdo, long *ndesktops)
    attach_function "xdo_get_number_of_desktops", [:pointer, :pointer], :int

    # int xdo_set_current_desktop (const xdo_t *xdo, long desktop)
    attach_function "xdo_set_current_desktop", [:pointer, :long], :int

    # int xdo_get_current_desktop (const xdo_t *xdo, long *desktop)
    attach_function "xdo_get_current_desktop", [:pointer, :pointer], :int

    # int xdo_set_desktop_for_window (const xdo_t *xdo, Window wid, long desktop)
    # XXX: Window != pointer
    attach_function "xdo_set_desktop_for_window", [:pointer, :pointer, :long], :int

    # int xdo_get_desktop_for_window (const xdo_t *xdo, Window wid, long *desktop)
    # XXX: Window != pointer
    attach_function "xdo_get_desktop_for_window", [:pointer, :pointer, :pointer], :int

    # int xdo_window_search (const xdo_t *xdo, const xdo_search_t *search, Window **windowlist_ret, int *nwindows_ret)
    # XXX: xdo_search_t?  How do I make that.
    attach_function "xdo_window_search", [:pointer, :pointer, :pointer, :pointer], :int

    # unsigned char * xdo_getwinprop (const xdo_t *xdo, Window window, Atom atom, long *nitems, Atom *type, int *size)
    # XXX: Window != pointer
    # XXX: Atom != pointer
    # XXX: Unsigned char * != :string?
    attach_function "xdo_getwinprop", [:pointer, :pointer, :pointer, :pointer, :pointer, :pointer], :string

    # unsigned int xdo_get_input_state (const xdo_t *xdo)
    attach_function "xdo_get_input_state", [:pointer], :uint

    # const keysym_charmap_t * xdo_keysym_charmap (void)
    attach_function "xdo_keysym_charmap", [], :pointer

    # XXX: char** is an array of strings?
    # const char ** xdo_symbol_map (void)
    attach_function "xdo_symbol_map", [], [:string]

    # xdo_active_mods_t * xdo_get_active_modifiers (const xdo_t *xdo)
    attach_function "xdo_get_active_modifiers", [:pointer], :pointer

    # int xdo_clear_active_modifiers (const xdo_t *xdo, Window window, xdo_active_mods_t *active_mods)
    attach_function "xdo_clear_active_modifiers", [:pointer, :pointer, :pointer], :int

    # int xdo_set_active_modifiers (const xdo_t *xdo, Window window, const xdo_active_mods_t *active_mods)
    # XXX: Window != pointer
    attach_function "xdo_set_active_modifiers" (const xdo_t *xdo, Window window, const xdo_active_mods_t *active_mods), :int

    # void xdo_free_active_modifiers (xdo_active_mods_t *active_mods)
    attach_function "xdo_free_active_modifiers", [:pointer], :void

    class Xdo < FFI::Struct
 	  # The Display for Xlib. 
      # Display * xdpy
      layout :xdpy                     ,:pointer, # Display * xdpy
             :display_name             ,:string,  # The display name.
             :charcodes                ,:pointer, # charcodemap_t * charcodes
             :charcodes_len            ,:int, 
             :modmap                   ,:pointer, # XModifierKeymap * modmap
             :keymap                   ,:pointer, # KeySym * keymap
             :keycode_high             ,:int, 
             :keycode_low              ,:int, 
             :keysyms_per_keycode      ,:int, 
             :close_display_when_freed ,:int  # Should we close the display when calling xdo_free?
    end

    class KeysymCharmap < FFI::Struct
      layout :keysym ,:string, 
             :key    ,:char
    end

    # XXX: Is the native documentation off by a field?  Feels like it.
    class Charcodemap < FFI::Struct
      # XXX: keycode isn"t a type
      layout :code          ,:KeyCode, # the letter for this key, like "a"
             :symbol        ,:KeySym,  # the keycode that this key is on
             :index         ,:int,     # the symbol representing this key
             :modmask       ,:int,     # the index in the keysym-per-keycode list that is this key
             :needs_binding ,:int      # the modifiers activated by this key
    end

    class XdoActiveMods < FFI::Struct
      layout :keymods, :pointer  # charcodemap_t * keymods
             :nkeymods, :int     # int nkeymods
             :input_state, :uint # unsigned int input_state
    end

    class XdoSearch < FFI::Struct
      layout :title        ,:string,      # char * title
             :winclass     ,:string,      # char * winclass # pattern to test against a window title
             :winclassname ,:string,      # char * winclassname # pattern to test against a window class
             :winname      ,:string,      # char *	winname # pattern to test against a window class
             :pid          ,:int,         # int pid # window pid (From window atom _NET_WM_PID)
             :max_depth    ,:long,        # long max_depth # depth of search.
             :only_visible ,:int,         # only_visible   boolean; set true to search only visible windows
             :screen       ,:int,         # screen
             # XXX: Map this enum. Not sure how that works.
             :xdo_search   ,:search_enum, # what screen to search, if any.
             :searchmask   ,:uint         # unsigned int searchmask # bitmask of things you are searching for, such as SEARCH_NAME                                               , etc.
    end
  end
end
