import paramidib, nimib

nbInit
nbCode:
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
nbSave