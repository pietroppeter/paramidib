# adapted from https://github.com/paranim/paramidi_starter/blob/master/src/paramidi_starter.nim
from paramidib / common import nil
import paramidi
import paramidi/tsf
import paramidi_soundfonts
import os

export paramidi

template saveMusic*(wavFile: string, score: untyped) =
  let scoreObject = score
  # get the sound font, read it from disc
  var sf = tsf_load_filename(paramidi_soundfonts.getSoundFontPath("generaluser.sf2"))
  const sampleRate = 44100
  tsf_set_output(sf, TSF_MONO, sampleRate, 0)
  var res = render[cshort](compile(scoreObject), sf, sampleRate)
  tsf_close(sf)
  # create the wav file (without playing it)
  common.writeFile(wavFile, res.data, res.data.len.uint32, sampleRate)

template nbAudio*(wavFile: string) =
  # todo: validate/escape wavFile
  nbText: """<audio controls>
  <source src="""" & joinPath(nb.srcDirRel.string, wavFile) & """" type="audio/wav">
Your browser does not support the audio element.
</audio>
"""
