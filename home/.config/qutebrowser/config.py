config.load_autoconfig()
config.source("desert-witch.py")
c.url.start_pages = ["about:blank"]
c.url.default_page = "about:blank"
c.colors.webpage.preferred_color_scheme = "light"
c.completion.shrink = True
c.content.autoplay = False
c.editor.command = ["kitty", "nvim", "{file}"]
c.scrolling.smooth = True
config.bind("<Ctrl-]>", "tab-next")
config.bind("<Ctrl-[>", "tab-prev")
config.bind("<Ctrl-=>", "zoom-in")
config.bind("<Ctrl-Backspace>", "zoom")
config.bind(",m", "spawn mpv {url}")
config.bind(",M", "hint links spawn mpv {hint-url}")
config.bind(
    "<Alt-p>", "clear-messages ;; config-cycle content.images ;; set content.images"
)
c.aliases["cheatsheet"] = (
    "open https://raw.githubusercontent.com/qutebrowser/qutebrowser/main/doc/img/cheatsheet-big.png"
)
c.aliases["m"] = "open !mw"
c.aliases["mwt"] = "open !mwt"
c.aliases["rz"] = "open !rz"
c.aliases["w"] = "open !w"
c.aliases["wt"] = "open !wt"
