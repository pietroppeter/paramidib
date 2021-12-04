import nimib

nbInit
nbText: """# 🎶🐳 paramidib

paramidi**b** is an easy way to make [paramidi] available with [nimib].
Install with `nimble install paramidib`.

It exports `paramidi` and provides two templates:
  1. `saveMusic`: takes a valid score for paramidi and creates
     a `wav` file with the generated music.
     It is adapted from [paramidi_starter] and it can be used even
     without nimib (paramidib itself does not depend on nimib).
  2. `nbAudio`: a new nimib block which create an audio control
     to play the `wav` file.
     In the following example is called with `nbAudio("output.wav")`

[paramidi]: https://github.com/paranim/paramidi
[nimib]: https://github.com/pietroppeter/nimib
[paramidi_starter]: https://github.com/paranim/paramidi_starter

"""
nbCode:
  import paramidib

  saveMusic("output.wav"):
    (piano,
      (tempo: 74),
      1/8, {-d, -a, e, fx}, a,
      1/2, {fx, +d},
      1/8, {-e, e, +c}, a,
      1/2, {c, e},
      1/8, {-d, -a, e, fx}, a, +d, +cx, +e, +d, b, +cx,
      1/2, {-e, c, a}, {c, e})
nbAudio("output.wav")
nbText: "Another example where the score is a json object generated at runtime:"
nbCode:
  import json

  let
    measure1 = %*[1/16, "b", "c+", 1/8, "d+", "b", "c+", "a", "b", "g", "a"]
    measure2 = %*[1/16, "g", "g", 1/8, "g", "a", "b", "c+", "d+", "c+", 1/2, "b"]
    measure3 = %*[1/16, [{"mode": "concurrent"}, "d", "b-", "g-"], [{"mode": "concurrent"}, "d", "b-", "g-"],
                  1/8, [{"mode": "concurrent"}, "d", "b-", "g-"], [{"mode": "concurrent"}, "e", "c", "g-"],
                  [{"mode": "concurrent"}, "d", "b-", "g-"]]
    measure4 = %*[1/16, "r", "r", 1/8, "g", "r", "d", "r", "g", "g", "d"]
    measure5 = %*[1/4, "g", 1/8, "a", "b", 1/4, "g", 1/8, "a", "d"]
    measure6 = %*[1/4, "g", 1/8, "a", "b", 1/4, "g", 1/8, [{"mode": "concurrent"}, "f", "a-"], "b", 1/4, "c"]

    score* =
      %*[{"tempo": 80, "octave": 3},
        ["guitar", measure1],
        ["banjo", measure1],
        ["guitar", measure1],
        ["guitar", 1/2, "d", 1/8, "g", "g", "a", "b", "g", "b", 1/2, "a"],
        ["banjo", 1/8, "g", "g", "a", "b", 1/2, "g"],
        ["guitar", {"octave": 2}, measure2],
        ["banjo", measure2],
        ["guitar", {"octave": 2}, measure2],
        ["banjo", measure2],
        ["guitar", measure2],
        ["banjo", measure2],
        {"octave": 4},
        ["guitar", measure3],
        ["banjo", measure3],
        ["guitar", measure3],
        ["banjo", measure3],
        ["guitar", {"octave": 2}, measure1],
        ["banjo", {"octave": 3}, measure1],
        {"tempo": 120, "octave": 3},
        [{"mode": "concurrent"},
          ["banjo", measure1],
          ["guitar", measure4]],
        [{"mode": "concurrent"},
          ["banjo", measure1],
          ["guitar", measure4]],
        [{"mode": "concurrent"},
          ["banjo", measure1],
          ["guitar", measure5]],
        [{"mode": "concurrent"},
          ["banjo", measure1],
          ["guitar", measure6]]]

  saveMusic("dueling_banjos.wav", score)
nbAudio("dueling_banjos.wav")
nbText: "Originally created for Advent Of Nim 🎄👑, 2021, Day 3, [Whale Music](https://pietroppeter.github.io/adventofnim/2021/day03.html#whale_music) 🐳🎶."
nbSave