- implement variant glyphs (and somehow let numbers be used in key input)
  - could just not use numbers for input
  - can assign the same key to different words (so `sewi` is sewi01 and sewi02, distinguish them via IME's hint)
- character combos with joiners should ideally be able to be typed as one sequence (`ijo-ni [space]`) rather than multiple (`ijo [space] - ni [space]`), however this probably means manually defining all of those sequences unless theres a better way to do it

all of the above would be much easier to implement in a custom made IME, tables are too limited to implement it well, maybe in the case of improvements to joiners they could be automated using a script
