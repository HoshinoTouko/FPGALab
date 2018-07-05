
 
 
 

 



window new WaveWindow  -name  "Waves for BMG Example Design"
waveform  using  "Waves for BMG Example Design"


      waveform add -signals /ROM_D_tb/status
      waveform add -signals /ROM_D_tb/ROM_D_synth_inst/bmg_port/CLKA
      waveform add -signals /ROM_D_tb/ROM_D_synth_inst/bmg_port/ADDRA
      waveform add -signals /ROM_D_tb/ROM_D_synth_inst/bmg_port/DINA
      waveform add -signals /ROM_D_tb/ROM_D_synth_inst/bmg_port/WEA
      waveform add -signals /ROM_D_tb/ROM_D_synth_inst/bmg_port/DOUTA
console submit -using simulator -wait no "run"
