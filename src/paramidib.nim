# adapted from https://github.com/paranim/paramidi_starter/blob/master/src/paramidi_starter.nim
from paramidib / common import nil
import paramidi
import paramidi/tsf
import paramidi_soundfonts

export paramidi

template saveMusic*(wavFile: string, score: untyped) =
  let scoreObject = score
  # get the sound font, read it from disc
  var sf = tsf_load_filename(paramidi_soundfonts.getSoundFontPath("generaluser.sf2"))
  const sampleRate = 44100
  tsf_set_output(sf, TSF_MONO, sampleRate, 0)
  var res = render[cshort](compile(score), sf, sampleRate)
  # create the wav file and play it
  const
    writeToDisk = true # if false, the wav file will only exist in memory
    padding = 500f # add a half second so it doesn't cut off abruptly
  # writeToDisk:
  common.writeFile(wavFile, res.data, res.data.len.uint32, sampleRate)
  common.play(wavFile, int(res.seconds * 1000f + padding))
