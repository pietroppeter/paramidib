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
  var res = render[cshort](compile(scoreObject), sf, sampleRate)
  # create the wav file (without playing it)
  # writeToDisk:
  common.writeFile(wavFile, res.data, res.data.len.uint32, sampleRate)
  #const
  #  padding = 500f # add a half second so it doesn't cut off abruptly
  #common.play(wavFile, int(res.seconds * 1000f + padding))

template nbAudio*(wavFile: string) =
  nbText: """<audio controls>
  <source src="""" & wavFile & """" type="audio/wav">
Your browser does not support the audio element.
</audio>
"""